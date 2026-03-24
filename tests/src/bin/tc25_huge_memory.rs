// TC25: 1 KB buffer (256 i32 cells).
//
// Sequence:
//   1. host_scan_all  — host reads every cell (invisible to R3, excluded fn).
//   2. host_write_random — host writes a non-zero LCG value to every cell.
//   3. wasm reads every 4th cell (64 reads) → 64 Load events.
//
// The LCG is inlined directly inside host_write_random (no helper call) to
// avoid the table_get error: any non-host, non-exported fn called from an
// excluded fn would trigger EnterProbe with EXT on the stack → crash.

const N: usize = 256; // 256 × 4 bytes = 1 KB

static mut MEM: [i32; N] = [0i32; N];
static mut OUT: [i32; N / 4] = [0i32; N / 4]; // 64 sampled results

// Step 1: host reads every cell — pure scan, no writes.
// Since host_* is excluded, these reads generate no Load events in R3.
#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_scan_all() -> i32 {
    let mut sum = 0i32;
    let mut i = 0usize;
    while i < N {
        sum = sum.wrapping_add(MEM[i]);
        i += 1;
    }
    sum // returned so the loop is not optimised away
}

// Step 2: host writes a non-zero LCG value to every cell.
// LCG is inlined (no helper fn call) to avoid the table_get issue.
// Multiplier/increment from Numerical Recipes; result forced > 0 via | 1.
#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_write_random() {
    let mut state: u32 = 0xDEAD_BEEF;
    let mut i = 0usize;
    while i < N {
        state = state.wrapping_mul(1_664_525).wrapping_add(1_013_904_223);
        MEM[i] = (state >> 1) as i32 | 1; // always odd, always > 0
        i += 1;
    }
}

fn main() {
    unsafe {
        // Step 1: host scans all 256 cells (reads, no Load events)
        host_scan_all();

        // Step 2: host overwrites all 256 cells with random non-zero values
        host_write_random();

        // Step 3: wasm reads every 4th cell — 64 Load events
        // (shadow is 0 everywhere; host wrote non-zero; every read is a miss)
        let mut i = 0usize;
        while i < N / 4 {
            OUT[i] = MEM[i * 4];
            i += 1;
        }
    }
}
