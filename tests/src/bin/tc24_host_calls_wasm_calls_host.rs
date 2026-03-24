// TC24: host_outer (excluded) → wasm_mid (not excluded, gets EC) → host_inner
// (excluded, gets IC/IR from inside wasm_mid) → back.
// This is the most complex call pattern: IC(outer) EC(mid) IC(inner) IR(inner) L IR(outer)
static mut VAL_A: i32 = 0;
static mut VAL_B: i32 = 0;
static mut OUT: [i32; 2] = [0; 2];

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_inner(v: i32) { VAL_B = v * 3; }

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn wasm_mid(x: i32) {
    // Called from inside host_outer while EXT is on stack → EC event
    host_inner(x + 1);  // IC;host_inner IR;host_inner
    OUT[1] = VAL_B;     // Load event for VAL_B
}

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_outer(v: i32) {
    VAL_A = v * 2;
    wasm_mid(v);       // EC fires for wasm_mid (EXT on stack from host_outer)
}

fn main() {
    unsafe {
        host_outer(7);  // IC;host_outer  EC;wasm_mid IC;host_inner IR;host_inner L;VAL_B  IR;host_outer
        OUT[0] = VAL_A; // Load event for VAL_A (after IR for host_outer)
        // VAL_A = 14, VAL_B = (7+1)*3 = 24
    }
}
