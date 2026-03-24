// TC22: host recursively accumulates into a counter (writes at each depth).
// R3 sees one IC/IR for the outermost call.
// The final accumulated value triggers ONE Load event (counter is at a single addr).
static mut COUNTER: i32 = 0;

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_accumulate(n: i32) {
    if n <= 0 { return; }
    COUNTER += n;           // write at each depth
    host_accumulate(n - 1); // recursive call invisible to R3
}

static mut OUT: i32 = 0;

fn main() {
    unsafe {
        COUNTER = 0;
        host_accumulate(10);  // IC IR (sum = 10+9+...+1 = 55)
        OUT = COUNTER;        // Load event: 55
    }
}
