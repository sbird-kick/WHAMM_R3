// TC07: host function calls itself recursively. From R3's perspective, the
// entire recursion is ONE opaque host call (no IC/IR for inner calls —
// excluded functions have no probes). But all memory writes from all
// recursive levels accumulate before wasm reads.
// Expect: IC IR  then N Load events (one per recursion depth).
static mut ARR: [i32; 6] = [0; 6];

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_recurse(depth: usize) {
    if depth >= 6 { return; }
    ARR[depth] = depth as i32 * 10;
    host_recurse(depth + 1); // invisible to R3 (excluded calls excluded)
}

static mut SUM: i32 = 0;

fn main() {
    unsafe {
        host_recurse(0);
        // R3 sees one IC/IR. After IR, wasm reads all 6 cells.
        let mut s = 0i32;
        let mut i = 0usize;
        while i < 6 { s += ARR[i]; i += 1; } // 6 Load events
        SUM = s; // 0+10+20+30+40+50 = 150
    }
}
