use once_cell::sync::Lazy;
use std::alloc::{alloc, Layout};
use std::collections::HashMap;
use std::mem::{align_of, size_of};
use std::sync::Mutex;

// ── Types ────────────────────────────────────────────────────────────────

enum ParamValue { I32(i32), I64(i64), F32(f32), F64(f64) }

// event_type: 0 = EC, 1 = IR
enum TraceEvent {
    Load { mem: u32, addr: u32, bytes: Vec<u8> },
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
    shadows: Vec<Vec<u8>>,          // one shadow per memory, indexed by memidx
    shadow_globals: Vec<i64>,
    trace: Vec<TraceEvent>,
    building: Option<EventBuilder>,
    names: HashMap<u32, String>,
    shadow_pages: Vec<u32>,         // per-memory page count for MG detection
    pages_registered: Vec<bool>,    // true once init_mem_pages seeded the baseline
    passive: HashMap<u32, Vec<u8>>, // passive data segments, registered at @init
}

static STATE: Lazy<Mutex<State>> = Lazy::new(|| Mutex::new(State {
    shadows: Vec::new(), shadow_globals: Vec::new(), trace: Vec::new(),
    building: None, names: HashMap::new(), shadow_pages: Vec::new(),
    pages_registered: Vec::new(), passive: HashMap::new(),
}));

fn shadow_of(s: &mut State, mem: u32) -> &mut Vec<u8> {
    if mem as usize >= s.shadows.len() { s.shadows.resize(mem as usize + 1, Vec::new()); }
    &mut s.shadows[mem as usize]
}

fn mask(size: u32) -> i64 {
    if size >= 8 { -1i64 } else { (1i64 << (size * 8)) - 1 }
}

fn fmt_param(p: &ParamValue) -> String {
    match p {
        ParamValue::I32(v) => format!("{}", v),
        ParamValue::I64(v) => format!("{}", v),
        ParamValue::F32(v) => format!("0x{:X}", v.to_bits()),
        ParamValue::F64(v) => format!("0x{:X}", v.to_bits()),
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
    let sh = shadow_of(&mut s, 0);
    let end = (start + len) as usize;
    if end > sh.len() { sh.resize(end, 0); }
    for i in 0..len {
        sh[(start + i) as usize] = unsafe { *((data_ptr as usize + i as usize) as *const u8) };
    }
    0
}

fn write_shadow(sh: &mut Vec<u8>, addr: u32, size: u32, value: i64) {
    let end = (addr + size) as usize;
    if end > sh.len() { sh.resize(end, 0); }
    for i in 0..size { sh[(addr + i) as usize] = ((value >> (i * 8)) & 0xFF) as u8; }
}

#[no_mangle]
pub fn shadow_store(mem: i32, addr: i32, size: i32, value: i64) {
    let mut s = STATE.lock().unwrap();
    write_shadow(shadow_of(&mut s, mem as u32), addr as u32, size as u32, value);
}

#[no_mangle]
pub fn check_load(mem: i32, addr: i32, size: i32, value: i64) {
    let (mem, addr, size) = (mem as u32, addr as u32, size as u32);
    let mut s = STATE.lock().unwrap();
    let m = mask(size);
    let sh = shadow_of(&mut s, mem);
    let mut shadow: i64 = 0;
    for i in 0..size {
        let idx = (addr + i) as usize;
        let b = if idx < sh.len() { sh[idx] } else { 0 };
        shadow |= (b as i64) << (i * 8);
    }
    if (value & m) != (shadow & m) {
        let bytes: Vec<u8> = (0..size).map(|i| ((value >> (i * 8)) & 0xFF) as u8).collect();
        write_shadow(sh, addr, size, value);
        s.trace.push(TraceEvent::Load { mem, addr, bytes });
    }
}

// ── Float store/load (bit-reinterpretation, not numeric conversion) ─────

#[no_mangle]
pub fn shadow_store_f32(mem: i32, addr: i32, val: f32) {
    shadow_store(mem, addr, 4, val.to_bits() as i64);
}

#[no_mangle]
pub fn shadow_store_f64(mem: i32, addr: i32, val: f64) {
    shadow_store(mem, addr, 8, val.to_bits() as i64);
}

#[no_mangle]
pub fn check_load_f32(mem: i32, addr: i32, val: f32) {
    check_load(mem, addr, 4, val.to_bits() as i64);
}

#[no_mangle]
pub fn check_load_f64(mem: i32, addr: i32, val: f64) {
    check_load(mem, addr, 8, val.to_bits() as i64);
}

// ── Bulk memory shadow updates ──────────────────────────────────────────

#[no_mangle]
pub fn shadow_grow(mem: i32, old_pages: i32, new_pages: i32) {
    if old_pages < 0 { return; }
    let mut s = STATE.lock().unwrap();
    let total = (old_pages + new_pages) as u32;
    let new_size = total as usize * 65536;
    let sh = shadow_of(&mut s, mem as u32);
    if new_size > sh.len() { sh.resize(new_size, 0); }
    // Update shadow_pages so check_mem_grow won't false-trigger for wasm-internal grows
    let mi = mem as usize;
    if mi >= s.shadow_pages.len() { s.shadow_pages.resize(mi + 1, 0); }
    if total > s.shadow_pages[mi] { s.shadow_pages[mi] = total; }
}

#[no_mangle]
pub fn shadow_fill(mem: i32, dest: i32, val: i32, len: i32) {
    let mut s = STATE.lock().unwrap();
    let sh = shadow_of(&mut s, mem as u32);
    let end = dest as usize + len as usize;
    if end > sh.len() { sh.resize(end, 0); }
    sh[dest as usize..end].fill(val as u8);
}

// Same-memory copy only: whamm exposes just one memidx immediate (imm0) on
// memory.copy, so cross-memory copies can't be routed (documented limitation).
#[no_mangle]
pub fn shadow_copy(mem: i32, dest: i32, src: i32, len: i32) {
    let mut s = STATE.lock().unwrap();
    let sh = shadow_of(&mut s, mem as u32);
    let (d, sr, n) = (dest as usize, src as usize, len as usize);
    let end = d.max(sr) + n;
    if end > sh.len() { sh.resize(end, 0); }
    sh.copy_within(sr..sr + n, d);
}

// ── Passive data segments (for memory.init shadow tracking) ─────────────

/// Register 8 bytes of a passive data segment at @init time.
#[no_mangle]
pub fn passive_chunk(segidx: i32, offset: i32, chunk: i64, chunk_len: i32) {
    let mut s = STATE.lock().unwrap();
    let seg = s.passive.entry(segidx as u32).or_default();
    let end = offset as usize + chunk_len as usize;
    if end > seg.len() { seg.resize(end, 0); }
    for i in 0..chunk_len as usize {
        seg[offset as usize + i] = ((chunk >> (i * 8)) & 0xFF) as u8;
    }
}

/// memory.init executed by non-excluded code: apply segment bytes to the shadow.
#[no_mangle]
pub fn shadow_init(mem: i32, segidx: i32, dest: i32, src_off: i32, len: i32) {
    let mut s = STATE.lock().unwrap();
    let bytes: Vec<u8> = match s.passive.get(&(segidx as u32)) {
        Some(seg) => {
            let (o, n) = (src_off as usize, len as usize);
            if o + n > seg.len() { return; } // module would trap; shadow state moot
            seg[o..o + n].to_vec()
        }
        None => return,
    };
    let sh = shadow_of(&mut s, mem as u32);
    let end = dest as usize + bytes.len();
    if end > sh.len() { sh.resize(end, 0); }
    sh[dest as usize..end].copy_from_slice(&bytes);
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

// Float shadows hold IEEE bits, matching check_global_f32/f64.
#[no_mangle]
pub fn shadow_global_set_f32(idx: i32, val: f32) {
    let mut s = STATE.lock().unwrap();
    ensure_globals(&mut s, idx as u32);
    s.shadow_globals[idx as usize] = val.to_bits() as i64;
}

#[no_mangle]
pub fn shadow_global_set_f64(idx: i32, val: f64) {
    let mut s = STATE.lock().unwrap();
    ensure_globals(&mut s, idx as u32);
    s.shadow_globals[idx as usize] = val.to_bits() as i64;
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
            0 => s.trace.push(TraceEvent::ExternalCall { fid: b.fid, params: b.params }),
            _ => s.trace.push(TraceEvent::ImportReturn { fid: b.fid, results: b.params }),
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

// Seed the MG baseline from the module's DECLARED initial page count (@init).
// Without this, a host-side grow before the first EC/IR boundary would be
// silently adopted as the baseline instead of emitting MG (the oracle
// baselines at instantiation).
#[no_mangle]
pub fn init_mem_pages(mem: i32, pages: i32) {
    let mut s = STATE.lock().unwrap();
    let mi = mem as usize;
    if mi >= s.shadow_pages.len() { s.shadow_pages.resize(mi + 1, 0); }
    if mi >= s.pages_registered.len() { s.pages_registered.resize(mi + 1, false); }
    s.shadow_pages[mi] = pages as u32;
    s.pages_registered[mi] = true;
}

#[no_mangle]
pub fn check_mem_grow(mem: i32, current_pages: i32) {
    let mut s = STATE.lock().unwrap();
    let (mi, current) = (mem as usize, current_pages as u32);
    if mi >= s.shadow_pages.len() { s.shadow_pages.resize(mi + 1, 0); }
    let registered = s.pages_registered.get(mi).copied().unwrap_or(false);
    if !registered && s.shadow_pages[mi] == 0 {
        // Fallback for memories the generator didn't register: baseline lazily.
        s.shadow_pages[mi] = current;
    } else if current > s.shadow_pages[mi] {
        let growth = current - s.shadow_pages[mi];
        s.trace.push(TraceEvent::MemGrow { mem_idx: mem as u32, pages: growth });
        s.shadow_pages[mi] = current;
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
            TraceEvent::Load { mem, addr, bytes } => {
                let v: Vec<String> = bytes.iter().map(|b| b.to_string()).collect();
                println!("L;{};{};{}", mem, addr, v.join(","));
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
