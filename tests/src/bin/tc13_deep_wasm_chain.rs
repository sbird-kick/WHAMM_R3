// TC13: deep wasm call chain leading to a host call.
// main → wasm_f1 → wasm_f2 → wasm_f3 → host_deep → returns.
// All wasm functions are non-excluded, so each generates only INT entries.
// host_deep generates IC/IR at the deepest level.
// Load events appear where wasm reads the host-written data after returning.
static mut DEEP_VAL: i32 = 0;
static mut CHAIN_OUT: [i32; 3] = [0; 3];

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_deep(v: i32) { DEEP_VAL = v; }

#[inline(never)]
unsafe fn wasm_f3() {
    host_deep(777);              // IC;host_deep IR;host_deep
    CHAIN_OUT[2] = DEEP_VAL;     // Load event
}

#[inline(never)]
unsafe fn wasm_f2() {
    wasm_f3();
    CHAIN_OUT[1] = DEEP_VAL;     // Load event (shadow already updated, no new L)
}

#[inline(never)]
unsafe fn wasm_f1() {
    wasm_f2();
    CHAIN_OUT[0] = DEEP_VAL;     // same shadow value, no L
}

fn main() {
    unsafe { wasm_f1(); }
}
