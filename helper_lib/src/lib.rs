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
    has_had_ic: bool,
}

impl R3MemState {
    fn new() -> Self {
        R3MemState { shadow: HashMap::new(), trace: Vec::new(), has_had_ic: false }
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
#[no_mangle]
pub fn record_ec(fid: i32) {
    STATE.lock().unwrap().trace.push(TraceEvent::Ec { fid: fid as u32 });
}

/// IC: import call (wasm→host).
#[no_mangle]
pub fn record_ic(fid: i32) {
    let mut state = STATE.lock().unwrap();
    state.has_had_ic = true;
    state.trace.push(TraceEvent::Ic { fid: fid as u32 });
}

/// IR: import return (host→wasm return).
#[no_mangle]
pub fn record_ir(fid: i32) {
    STATE.lock().unwrap().trace.push(TraceEvent::Ir { fid: fid as u32 });
}

/// Called before every wasm integer store. Updates shadow.
#[no_mangle]
pub fn shadow_store(addr: i32, size: i32, value: i64) {
    let mut state = STATE.lock().unwrap();
    state.write_shadow(addr as u32, size as u32, value);
}

/// Called after every wasm integer load. Emits an L event on shadow mismatch.
/// Lazy seeding: first read of an untracked address seeds shadow without emitting L.
/// This avoids false positives from data-section-initialized memory.
#[no_mangle]
pub fn check_load(addr: i32, size: i32, value: i64) {
    let addr = addr as u32;
    let size = size as u32;
    let mut state = STATE.lock().unwrap();
    // Before any IC, lazy-seed untracked addresses to absorb data-section reads.
    // After IC the host may have written, so we must compare.
    let all_tracked = (0..size).all(|i| state.shadow.contains_key(&(addr + i)));
    if !state.has_had_ic && !all_tracked {
        state.write_shadow(addr, size, value);
        return;
    }
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

/// Print all recorded events in R3 trace format, interleaved in execution order.
#[no_mangle]
pub fn print_trace() {
    let state = STATE.lock().unwrap();
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
