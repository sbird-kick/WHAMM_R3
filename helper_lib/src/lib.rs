use once_cell::sync::Lazy;
use std::alloc::{alloc, dealloc, Layout};
use std::collections::HashMap;
use std::mem::{align_of, size_of};
use std::sync::Mutex;

// ── Trace event types ─────────────────────────────────────────────────────

enum TraceEvent {
    Ec { fid: u32 },
    Ic { fid: u32 },
    Ir { fid: u32 },
    Load { addr: u32, bytes: Vec<u8> },
}

// ── State ─────────────────────────────────────────────────────────────────

struct R3MemState {
    shadow: HashMap<u32, u8>,
    trace: Vec<TraceEvent>,
    /// Pending IC event: (target_fid, caller_fid).
    /// Deferred so that when call:before fires at the same code position as
    /// func:entry (whamm insertion ordering), we can place EC before IC.
    pending_ic: Option<(u32, u32)>,
}

impl R3MemState {
    fn new() -> Self {
        R3MemState { shadow: HashMap::new(), trace: Vec::new(), pending_ic: None }
    }

    fn flush_pending_ic(&mut self) {
        if let Some((target_fid, _)) = self.pending_ic.take() {
            self.trace.push(TraceEvent::Ic { fid: target_fid });
        }
    }

    fn write_shadow(&mut self, addr: u32, size: u32, value: i64) {
        for i in 0..size {
            let byte = ((value >> (i * 8)) & 0xFF) as u8;
            self.shadow.insert(addr + i, byte);
        }
    }

    fn read_shadow(&self, addr: u32, size: u32) -> i64 {
        let mut result: i64 = 0;
        for i in 0..size {
            let byte = *self.shadow.get(&(addr + i)).unwrap_or(&0) as i64;
            result |= byte << (i * 8);
        }
        result
    }

    fn mask(size: u32) -> i64 {
        if size >= 8 { -1i64 } else { (1i64 << (size * 8)) - 1 }
    }
}

static STATE: Lazy<Mutex<R3MemState>> = Lazy::new(|| Mutex::new(R3MemState::new()));

// ── Memory allocator (required for write_str / fname passing) ─────────────

#[no_mangle]
pub fn mem_alloc(len: i32) -> i32 {
    if len <= 0 { return 0; }
    let len = len as usize;
    let header = size_of::<usize>();
    let layout = Layout::from_size_align(header + len, align_of::<usize>()).unwrap();
    unsafe {
        let raw = alloc(layout);
        *(raw as *mut usize) = len;
        raw.add(header) as i32
    }
}

#[no_mangle]
pub fn mem_free(ptr: i32) {
    if ptr == 0 { return; }
    let header = size_of::<usize>();
    unsafe {
        let raw = (ptr as *mut u8).sub(header);
        let len = *(raw as *mut usize);
        let layout = Layout::from_size_align(header + len, align_of::<usize>()).unwrap();
        dealloc(raw, layout);
    }
}

// ── Exported probe functions ──────────────────────────────────────────────

/// EC: external (host→wasm) call.
/// If there is a pending IC whose caller matches this EC's fid, the IC was
/// placed before EC due to whamm insertion ordering — emit EC first, then IC.
/// Otherwise flush any pending IC before this EC (genuine execution order).
#[no_mangle]
pub fn record_ec(fid: i32) {
    let mut state = STATE.lock().unwrap();
    let fid = fid as u32;
    if let Some((_, caller_fid)) = state.pending_ic {
        if caller_fid == fid {
            // Same function entry — whamm ordering artifact: EC before IC
            let (target_fid, _) = state.pending_ic.take().unwrap();
            state.trace.push(TraceEvent::Ec { fid });
            state.trace.push(TraceEvent::Ic { fid: target_fid });
        } else {
            // Different function — flush IC first (genuine order), then EC
            state.flush_pending_ic();
            state.trace.push(TraceEvent::Ec { fid });
        }
    } else {
        state.trace.push(TraceEvent::Ec { fid });
    }
}

/// IC: import call (wasm→host). Deferred as pending so EC ordering can be fixed.
#[no_mangle]
pub fn record_ic(target_fid: i32, caller_fid: i32) {
    let mut state = STATE.lock().unwrap();
    // Flush any existing pending IC before storing the new one
    state.flush_pending_ic();
    state.pending_ic = Some((target_fid as u32, caller_fid as u32));
}

/// IR: import return (host→wasm return).
#[no_mangle]
pub fn record_ir(fid: i32) {
    let mut state = STATE.lock().unwrap();
    state.flush_pending_ic();
    state.trace.push(TraceEvent::Ir { fid: fid as u32 });
}

/// Called before every wasm integer store. Updates shadow.
#[no_mangle]
pub fn shadow_store(addr: i32, size: i32, value: i64) {
    let mut state = STATE.lock().unwrap();
    state.write_shadow(addr as u32, size as u32, value);
}

/// Called after every wasm integer load. Emits an L event on shadow mismatch.
#[no_mangle]
pub fn check_load(addr: i32, size: i32, value: i64) {
    let addr = addr as u32;
    let size = size as u32;
    let mut state = STATE.lock().unwrap();
    state.flush_pending_ic();
    let shadow_val = state.read_shadow(addr, size);
    let m = R3MemState::mask(size);
    let masked_value = value & m;
    let masked_shadow = shadow_val & m;
    if masked_value != masked_shadow {
        let bytes: Vec<u8> = (0..size)
            .map(|i| ((masked_value >> (i * 8)) & 0xFF) as u8)
            .collect();
        state.trace.push(TraceEvent::Load { addr, bytes });
        state.write_shadow(addr, size, value);
    }
}

/// Seed shadow memory from a copy of the app's data segments.
/// `data_ptr` points into r3_mem's own memory where the bytes were copied.
/// `start_addr` is the starting address in the app's linear memory.
/// `len` is the number of bytes.
#[no_mangle]
pub fn init_shadow(data_ptr: i32, start_addr: i32, len: i32) {
    let mut state = STATE.lock().unwrap();
    let start_addr = start_addr as u32;
    let len = len as u32;
    for i in 0..len {
        let byte = unsafe { *((data_ptr as usize + i as usize) as *const u8) };
        state.shadow.insert(start_addr + i, byte);
    }
}

/// Print all recorded events in R3 trace format, interleaved in execution order.
#[no_mangle]
pub fn print_trace() {
    let mut state = STATE.lock().unwrap();
    state.flush_pending_ic();
    for event in &state.trace {
        match event {
            TraceEvent::Ec { fid } => println!("EC;{};fid;", fid),
            TraceEvent::Ic { fid }        => println!("IC;{}", fid),
            TraceEvent::Ir { fid }        => println!("IR;{};", fid),
            TraceEvent::Load { addr, bytes } => {
                let byte_str: Vec<String> = bytes.iter().map(|b| b.to_string()).collect();
                println!("L;0;{};{}", addr, byte_str.join(","));
            }
        }
    }
}
