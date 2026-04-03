use once_cell::sync::Lazy;
use std::alloc::{alloc, Layout};
use std::collections::HashMap;
use std::mem::{align_of, size_of};
use std::sync::Mutex;

// ── Types ────────────────────────────────────────────────────────────────

enum ParamValue { I32(i32), I64(i64), F32(f32), F64(f64) }

// event_type: 0 = EC, 1 = IR
enum TraceEvent {
    Load { addr: u32, bytes: Vec<u8> },
    ExternalCall { fid: u32, params: Vec<ParamValue> },
    ImportCall { fid: u32 },
    ImportReturn { fid: u32, results: Vec<ParamValue> },
    GlobalGet { idx: u32, formatted: String },
    ImportGlobal { idx: u32, formatted: String },
    MemGrow { mem_idx: u32, pages: u32 },
}

struct EventBuilder { event_type: i32, fid: u32, params: Vec<ParamValue> }

// ── State ────────────────────────────────────────────────────────────────

struct State {
    shadow: Vec<u8>,
    shadow_globals: Vec<i64>,
    trace: Vec<TraceEvent>,
    building: Option<EventBuilder>,
    names: HashMap<u32, String>,
    pending_mg: Vec<(u32, u32)>,  // (mem_idx, pages) — deferred until next IR/EC
}

static STATE: Lazy<Mutex<State>> = Lazy::new(|| Mutex::new(State {
    shadow: Vec::new(), shadow_globals: Vec::new(), trace: Vec::new(),
    building: None, names: HashMap::new(), pending_mg: Vec::new(),
}));

fn mask(size: u32) -> i64 {
    if size >= 8 { -1i64 } else { (1i64 << (size * 8)) - 1 }
}

fn fmt_param(p: &ParamValue) -> String {
    match p {
        ParamValue::I32(v) => format!("{}", v),
        ParamValue::I64(v) => format!("{}", v),
        ParamValue::F32(v) => format!("0x{:x}", v.to_bits()),
        ParamValue::F64(v) => format!("0x{:x}", v.to_bits()),
    }
}

// ── Exports ──────────────────────────────────────────────────────────────

#[no_mangle]
pub fn mem_alloc(len: i32) -> i32 {
    if len <= 0 { return 0; }
    let len = len as usize;
    let hdr = size_of::<usize>();
    let layout = Layout::from_size_align(hdr + len, align_of::<usize>()).unwrap();
    unsafe { let p = alloc(layout); *(p as *mut usize) = len; p.add(hdr) as i32 }
}

#[no_mangle]
pub fn init_shadow(data_ptr: i32, start: i32, len: i32) -> i32 {
    let mut s = STATE.lock().unwrap();
    let (start, len) = (start as u32, len as u32);
    let end = (start + len) as usize;
    if end > s.shadow.len() { s.shadow.resize(end, 0); }
    for i in 0..len {
        s.shadow[(start + i) as usize] = unsafe { *((data_ptr as usize + i as usize) as *const u8) };
    }
    0
}

#[no_mangle]
pub fn shadow_store(addr: i32, size: i32, value: i64) {
    let mut s = STATE.lock().unwrap();
    let (addr, size) = (addr as u32, size as u32);
    let end = (addr + size) as usize;
    if end > s.shadow.len() { s.shadow.resize(end, 0); }
    for i in 0..size { s.shadow[(addr + i) as usize] = ((value >> (i * 8)) & 0xFF) as u8; }
}

#[no_mangle]
pub fn check_load(addr: i32, size: i32, value: i64) {
    let (addr, size) = (addr as u32, size as u32);
    let mut s = STATE.lock().unwrap();
    let m = mask(size);
    let mut shadow: i64 = 0;
    for i in 0..size {
        let idx = (addr + i) as usize;
        let b = if idx < s.shadow.len() { s.shadow[idx] } else { 0 };
        shadow |= (b as i64) << (i * 8);
    }
    if (value & m) != (shadow & m) {
        let bytes: Vec<u8> = (0..size).map(|i| ((value >> (i * 8)) & 0xFF) as u8).collect();
        s.trace.push(TraceEvent::Load { addr, bytes });
        let end = (addr + size) as usize;
        if end > s.shadow.len() { s.shadow.resize(end, 0); }
        for i in 0..size { s.shadow[(addr + i) as usize] = ((value >> (i * 8)) & 0xFF) as u8; }
    }
}

// ── Bulk memory shadow updates ──────────────────────────────────────────

#[no_mangle]
pub fn shadow_grow(old_pages: i32, new_pages: i32) {
    if old_pages < 0 { return; }
    let mut s = STATE.lock().unwrap();
    let new_size = (old_pages + new_pages) as usize * 65536;
    if new_size > s.shadow.len() { s.shadow.resize(new_size, 0); }
}

#[no_mangle]
pub fn shadow_fill(dest: i32, val: i32, len: i32) {
    let mut s = STATE.lock().unwrap();
    let end = dest as usize + len as usize;
    if end > s.shadow.len() { s.shadow.resize(end, 0); }
    s.shadow[dest as usize..end].fill(val as u8);
}

#[no_mangle]
pub fn shadow_copy(dest: i32, src: i32, len: i32) {
    let mut s = STATE.lock().unwrap();
    let (d, sr, n) = (dest as usize, src as usize, len as usize);
    let end = d.max(sr) + n;
    if end > s.shadow.len() { s.shadow.resize(end, 0); }
    s.shadow.copy_within(sr..sr + n, d);
}

// ── Shadow globals ──────────────────────────────────────────────────────

fn ensure_globals(s: &mut State, idx: u32) {
    if idx as usize >= s.shadow_globals.len() {
        s.shadow_globals.resize(idx as usize + 1, 0);
    }
}

#[no_mangle]
pub fn shadow_global_set(idx: i32, val: i64) {
    let mut s = STATE.lock().unwrap();
    ensure_globals(&mut s, idx as u32);
    s.shadow_globals[idx as usize] = val;
}

#[no_mangle]
pub fn check_global_i32(idx: i32, val: i32) {
    let mut s = STATE.lock().unwrap();
    ensure_globals(&mut s, idx as u32);
    let shadow = s.shadow_globals[idx as usize] as i32;
    if val != shadow {
        s.trace.push(TraceEvent::GlobalGet { idx: idx as u32, formatted: format!("{}", val) });
        s.shadow_globals[idx as usize] = val as i64;
    }
}

#[no_mangle]
pub fn check_global_i64(idx: i32, val: i64) {
    let mut s = STATE.lock().unwrap();
    ensure_globals(&mut s, idx as u32);
    if val != s.shadow_globals[idx as usize] {
        s.trace.push(TraceEvent::GlobalGet { idx: idx as u32, formatted: format!("{}", val) });
        s.shadow_globals[idx as usize] = val;
    }
}

#[no_mangle]
pub fn check_global_f32(idx: i32, val: f32) {
    let mut s = STATE.lock().unwrap();
    ensure_globals(&mut s, idx as u32);
    let bits = val.to_bits() as i64;
    if bits != s.shadow_globals[idx as usize] {
        s.trace.push(TraceEvent::GlobalGet { idx: idx as u32, formatted: format!("0x{:X}", val.to_bits()) });
        s.shadow_globals[idx as usize] = bits;
    }
}

#[no_mangle]
pub fn check_global_f64(idx: i32, val: f64) {
    let mut s = STATE.lock().unwrap();
    ensure_globals(&mut s, idx as u32);
    let bits = val.to_bits() as i64;
    if bits != s.shadow_globals[idx as usize] {
        s.trace.push(TraceEvent::GlobalGet { idx: idx as u32, formatted: format!("0x{:X}", val.to_bits()) });
        s.shadow_globals[idx as usize] = bits;
    }
}

// ── Name table ──────────────────────────────────────────────────────────

#[no_mangle]
pub fn register_name(fid: i32, ptr: i32, len: i32) -> i32 {
    let mut s = STATE.lock().unwrap();
    let bytes: Vec<u8> = (0..len as usize).map(|i| unsafe { *((ptr as usize + i) as *const u8) }).collect();
    s.names.insert(fid as u32, String::from_utf8(bytes).unwrap_or_default());
    0
}

// ── Event builder (EC=0, IR=1) ──────────────────────────────────────────

#[no_mangle]
pub fn begin_event(fid: i32, event_type: i32) {
    STATE.lock().unwrap().building = Some(EventBuilder { event_type, fid: fid as u32, params: Vec::new() });
}

#[no_mangle] pub fn param_i32(v: i32) { let mut s = STATE.lock().unwrap(); if let Some(b) = &mut s.building { b.params.push(ParamValue::I32(v)); } }
#[no_mangle] pub fn param_i64(v: i64) { let mut s = STATE.lock().unwrap(); if let Some(b) = &mut s.building { b.params.push(ParamValue::I64(v)); } }
#[no_mangle] pub fn param_f32(v: f32) { let mut s = STATE.lock().unwrap(); if let Some(b) = &mut s.building { b.params.push(ParamValue::F32(v)); } }
#[no_mangle] pub fn param_f64(v: f64) { let mut s = STATE.lock().unwrap(); if let Some(b) = &mut s.building { b.params.push(ParamValue::F64(v)); } }

#[no_mangle]
pub fn end_event() {
    let mut s = STATE.lock().unwrap();
    if let Some(b) = s.building.take() {
        match b.event_type {
            0 => {
                // EC: push EC first, then flush pending MG (oracle: EC then checkMemGrow)
                s.trace.push(TraceEvent::ExternalCall { fid: b.fid, params: b.params });
                flush_mg(&mut s);
            }
            _ => {
                // IR: push IR first, then flush pending MG (oracle: IR then checkMemGrow)
                s.trace.push(TraceEvent::ImportReturn { fid: b.fid, results: b.params });
                flush_mg(&mut s);
            }
        }
    }
}

#[no_mangle]
pub fn record_ic(fid: i32) {
    STATE.lock().unwrap().trace.push(TraceEvent::ImportCall { fid: fid as u32 });
}

#[no_mangle]
pub fn record_ig_i32(idx: i32, val: i32) {
    STATE.lock().unwrap().trace.push(TraceEvent::ImportGlobal { idx: idx as u32, formatted: format!("{}", val) });
}
#[no_mangle]
pub fn record_ig_i64(idx: i32, val: i64) {
    STATE.lock().unwrap().trace.push(TraceEvent::ImportGlobal { idx: idx as u32, formatted: format!("{}", val) });
}
#[no_mangle]
pub fn record_ig_f32(idx: i32, val: f32) {
    STATE.lock().unwrap().trace.push(TraceEvent::ImportGlobal { idx: idx as u32, formatted: format!("0x{:X}", val.to_bits()) });
}
#[no_mangle]
pub fn record_ig_f64(idx: i32, val: f64) {
    STATE.lock().unwrap().trace.push(TraceEvent::ImportGlobal { idx: idx as u32, formatted: format!("0x{:X}", val.to_bits()) });
}

#[no_mangle]
pub fn record_mg(mem_idx: i32, pages: i32) {
    STATE.lock().unwrap().pending_mg.push((mem_idx as u32, pages as u32));
}

fn flush_mg(s: &mut State) {
    for (mem_idx, pages) in s.pending_mg.drain(..) {
        s.trace.push(TraceEvent::MemGrow { mem_idx, pages });
    }
}

// ── Output ───────────────────────────────────────────────────────────────

#[no_mangle]
pub fn print_trace() {
    let s = STATE.lock().unwrap();

    // Pass 1: IG events first, sorted by global index
    let mut igs: Vec<(&u32, &String)> = s.trace.iter().filter_map(|ev| match ev {
        TraceEvent::ImportGlobal { idx, formatted } => Some((idx, formatted)),
        _ => None,
    }).collect();
    igs.sort_by_key(|(idx, _)| *idx);
    for (idx, formatted) in igs { println!("IG;{};{}", idx, formatted); }

    // Pass 2: everything else in order
    for ev in &s.trace {
        match ev {
            TraceEvent::ImportGlobal { .. } => {}
            TraceEvent::Load { addr, bytes } => {
                let v: Vec<String> = bytes.iter().map(|b| b.to_string()).collect();
                println!("L;0;{};{}", addr, v.join(","));
            }
            TraceEvent::ExternalCall { fid, params } => {
                let name = s.names.get(fid).map(|s| s.as_str()).unwrap_or("fid");
                let v: Vec<String> = params.iter().map(fmt_param).collect();
                println!("EC;{};{};{}", fid, name, v.join(","));
            }
            TraceEvent::ImportCall { fid } => println!("IC;{}", fid),
            TraceEvent::MemGrow { mem_idx, pages } => println!("MG;{};{}", mem_idx, pages),
            TraceEvent::GlobalGet { idx, formatted } => println!("G;{};{}", idx, formatted),
            TraceEvent::ImportReturn { fid, results } => {
                let v: Vec<String> = results.iter().map(fmt_param).collect();
                println!("IR;{};{}", fid, v.join(","));
            }
        }
    }
}
