// TC10: wasm → host_mid → wasm_inner → host_leaf
// host_mid (excluded) calls wasm_inner (not excluded) → EC event for wasm_inner.
// wasm_inner calls host_leaf → IC;host_leaf inside the EC context.
// Trace: IC;host_mid EC;wasm_inner IC;host_leaf IR;host_leaf [Loads] IR;host_mid
static mut A: i32 = 0;
static mut B: i32 = 0;
static mut OUT: [i32; 2] = [0; 2];

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_leaf(v: i32) { B = v; }

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn wasm_inner() {
    // This gets EC because EXT (host_mid) is on the stack.
    host_leaf(99);   // IC;host_leaf IR;host_leaf from inside wasm_inner
    OUT[1] = B;      // Load event for B
}

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_mid(v: i32) {
    A = v;
    wasm_inner(); // EC;wasm_inner fires when wasm_inner is entered
}

fn main() {
    unsafe {
        host_mid(55); // IC;host_mid  [EC;wasm_inner IC;host_leaf IR;host_leaf L;B]  IR;host_mid
        OUT[0] = A;   // Load event for A
    }
}
