// TC23: alternating wasm computation and host calls in a loop.
// Each host call writes a new value; wasm reads it. Multiple IC IR L cycles.
static mut SLOT: i32 = 0;
static mut OUT: [i32; 5] = [0; 5];

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_provide(v: i32) { SLOT = v; }

fn main() {
    unsafe {
        let mut i = 0usize;
        while i < 5 {
            host_provide(((i + 1) * 100) as i32); // IC IR each iteration
            OUT[i] = SLOT;                          // L each iteration
            i += 1;
        }
        // Expected trace: 5× (IC;host_provide IR;host_provide L)
        // L values: 100, 200, 300, 400, 500
    }
}
