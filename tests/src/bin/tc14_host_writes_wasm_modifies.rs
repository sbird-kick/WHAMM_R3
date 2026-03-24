// TC14: host writes array, wasm modifies some cells (wasm stores don't update
// shadow), then another host call writes more. Shows that wasm stores are
// invisible to R3 — subsequent reads of wasm-modified cells still generate
// Load events because shadow ≠ live.
static mut ARR: [i32; 4] = [0; 4];
static mut OUT: [i32; 4] = [0; 4];

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_init(base: i32) {
    let mut i = 0usize;
    while i < 4 { ARR[i] = base + i as i32; i += 1; }
}

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_patch(idx: usize, v: i32) { ARR[idx] = v; }

fn main() {
    unsafe {
        host_init(100);       // writes [100,101,102,103]
        // wasm modifies ARR[1] — shadow stays at 0 for this cell
        ARR[1] = 999;
        host_patch(2, 200);   // host overwrites ARR[2]

        // Read all: shadow 0 everywhere → all 4 are Load events
        let mut i = 0usize;
        while i < 4 { OUT[i] = ARR[i]; i += 1; }
        // Values: [100, 999, 200, 103]
    }
}
