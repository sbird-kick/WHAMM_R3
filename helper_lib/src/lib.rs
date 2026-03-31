use once_cell::sync::Lazy;
use std::alloc::{alloc, dealloc, Layout};
use std::collections::HashMap;
use std::mem::{align_of, size_of};
use std::sync::Mutex;

// ── Trace event types ─────────────────────────────────────────────────────

enum ParamValue {
    I32(i32),
    I64(i64),
    F32(f32),
    F64(f64),
}

enum TraceEvent {
    Load { addr: u32, bytes: Vec<u8> },
    ExternalCall { func_index: u32, params: Vec<ParamValue> },
    ImportCall { func_index: u32 },
    ImportReturn { func_index: u32, results: Vec<ParamValue> },
}

struct EventBuilder {
    func_index: u32,
    params: Vec<ParamValue>,
}

// ── State ─────────────────────────────────────────────────────────────────

struct R3MemState {
    shadow: Vec<u8>,
    trace: Vec<TraceEvent>,
    ec_building: Option<EventBuilder>,
    ir_building: Option<EventBuilder>,
    name_table: HashMap<u32, String>,
}

impl R3MemState {
    fn new() -> Self {
        R3MemState {
            shadow: Vec::new(),
            trace: Vec::new(),
            ec_building: None,
            ir_building: None,
            name_table: HashMap::new(),
        }
    }

    fn ensure_capacity(&mut self, end: u32) {
        let end = end as usize;
        if end > self.shadow.len() {
            self.shadow.resize(end, 0);
        }
    }

    fn write_shadow(&mut self, addr: u32, size: u32, value: i64) {
        self.ensure_capacity(addr + size);
        for i in 0..size {
            self.shadow[(addr + i) as usize] = ((value >> (i * 8)) & 0xFF) as u8;
        }
    }

    fn read_shadow(&self, addr: u32, size: u32) -> i64 {
        let mut result: i64 = 0;
        for i in 0..size {
            let idx = (addr + i) as usize;
            let byte = if idx < self.shadow.len() { self.shadow[idx] } else { 0 };
            result |= (byte as i64) << (i * 8);
        }
        result
    }

    fn mask(size: u32) -> i64 {
        if size >= 8 { -1i64 } else { (1i64 << (size * 8)) - 1 }
    }

    fn format_param(p: &ParamValue) -> String {
        match p {
            ParamValue::I32(v) => format!("{}", v),
            ParamValue::I64(v) => format!("{}", v),
            ParamValue::F32(v) => format!("0x{:x}", v.to_bits()),
            ParamValue::F64(v) => format!("0x{:x}", v.to_bits()),
        }
    }
}

static STATE: Lazy<Mutex<R3MemState>> = Lazy::new(|| Mutex::new(R3MemState::new()));

// ── Memory allocator ─────────────────────────────────────────────────────

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

// ── Shadow memory ───────────────────────────────────────────────────────

#[no_mangle]
pub fn shadow_store(addr: i32, size: i32, value: i64) {
    let mut state = STATE.lock().unwrap();
    state.write_shadow(addr as u32, size as u32, value);
}

#[no_mangle]
pub fn check_load(addr: i32, size: i32, value: i64) {
    let addr = addr as u32;
    let size = size as u32;
    let mut state = STATE.lock().unwrap();
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

#[no_mangle]
pub fn init_shadow(data_ptr: i32, start_addr: i32, len: i32) -> i32 {
    let mut state = STATE.lock().unwrap();
    let start_addr = start_addr as u32;
    let len = len as u32;
    state.ensure_capacity(start_addr + len);
    for i in 0..len {
        let byte = unsafe { *((data_ptr as usize + i as usize) as *const u8) };
        state.shadow[(start_addr + i) as usize] = byte;
    }
    0
}

// ── Name table ──────────────────────────────────────────────────────────

#[no_mangle]
pub fn register_name(fid: i32, ptr: i32, len: i32) -> i32 {
    let mut state = STATE.lock().unwrap();
    let bytes: Vec<u8> = (0..len as usize)
        .map(|i| unsafe { *((ptr as usize + i) as *const u8) })
        .collect();
    let name = String::from_utf8(bytes).unwrap_or_default();
    state.name_table.insert(fid as u32, name);
    0
}

// ── EC (External Call) builder ──────────────────────────────────────────

#[no_mangle]
pub fn begin_ec(fid: i32) {
    let mut state = STATE.lock().unwrap();
    state.ec_building = Some(EventBuilder {
        func_index: fid as u32,
        params: Vec::new(),
    });
}

#[no_mangle]
pub fn ec_param_i32(value: i32) {
    let mut state = STATE.lock().unwrap();
    if let Some(ref mut b) = state.ec_building { b.params.push(ParamValue::I32(value)); }
}

#[no_mangle]
pub fn ec_param_i64(value: i64) {
    let mut state = STATE.lock().unwrap();
    if let Some(ref mut b) = state.ec_building { b.params.push(ParamValue::I64(value)); }
}

#[no_mangle]
pub fn ec_param_f32(value: f32) {
    let mut state = STATE.lock().unwrap();
    if let Some(ref mut b) = state.ec_building { b.params.push(ParamValue::F32(value)); }
}

#[no_mangle]
pub fn ec_param_f64(value: f64) {
    let mut state = STATE.lock().unwrap();
    if let Some(ref mut b) = state.ec_building { b.params.push(ParamValue::F64(value)); }
}

#[no_mangle]
pub fn end_ec() {
    let mut state = STATE.lock().unwrap();
    if let Some(builder) = state.ec_building.take() {
        state.trace.push(TraceEvent::ExternalCall {
            func_index: builder.func_index,
            params: builder.params,
        });
    }
}

// ── IC (Import Call) ────────────────────────────────────────────────────

#[no_mangle]
pub fn record_ic(fid: i32) {
    let mut state = STATE.lock().unwrap();
    state.trace.push(TraceEvent::ImportCall { func_index: fid as u32 });
}

// ── IR (Import Return) builder ──────────────────────────────────────────

#[no_mangle]
pub fn begin_ir(fid: i32) {
    let mut state = STATE.lock().unwrap();
    state.ir_building = Some(EventBuilder {
        func_index: fid as u32,
        params: Vec::new(),
    });
}

#[no_mangle]
pub fn ir_result_i32(value: i32) {
    let mut state = STATE.lock().unwrap();
    if let Some(ref mut b) = state.ir_building { b.params.push(ParamValue::I32(value)); }
}

#[no_mangle]
pub fn ir_result_i64(value: i64) {
    let mut state = STATE.lock().unwrap();
    if let Some(ref mut b) = state.ir_building { b.params.push(ParamValue::I64(value)); }
}

#[no_mangle]
pub fn ir_result_f32(value: f32) {
    let mut state = STATE.lock().unwrap();
    if let Some(ref mut b) = state.ir_building { b.params.push(ParamValue::F32(value)); }
}

#[no_mangle]
pub fn ir_result_f64(value: f64) {
    let mut state = STATE.lock().unwrap();
    if let Some(ref mut b) = state.ir_building { b.params.push(ParamValue::F64(value)); }
}

#[no_mangle]
pub fn end_ir() {
    let mut state = STATE.lock().unwrap();
    if let Some(builder) = state.ir_building.take() {
        state.trace.push(TraceEvent::ImportReturn {
            func_index: builder.func_index,
            results: builder.params,
        });
    }
}

// ── Trace output ────────────────────────────────────────────────────────

#[no_mangle]
pub fn print_trace() {
    let state = STATE.lock().unwrap();
    for event in &state.trace {
        match event {
            TraceEvent::Load { addr, bytes } => {
                let s: Vec<String> = bytes.iter().map(|b| b.to_string()).collect();
                println!("L;0;{};{}", addr, s.join(","));
            }
            TraceEvent::ExternalCall { func_index, params } => {
                let name = state.name_table.get(func_index)
                    .map(|s| s.as_str()).unwrap_or("fid");
                let s: Vec<String> = params.iter().map(R3MemState::format_param).collect();
                println!("EC;{};{};{}", func_index, name, s.join(","));
            }
            TraceEvent::ImportCall { func_index } => {
                println!("IC;{}", func_index);
            }
            TraceEvent::ImportReturn { func_index, results } => {
                let s: Vec<String> = results.iter().map(R3MemState::format_param).collect();
                println!("IR;{};{}", func_index, s.join(","));
            }
        }
    }
}
