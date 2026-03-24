// TC12: host_even and host_odd call each other (mutual recursion, excluded→excluded).
// From R3's view: one IC/IR for whichever is called from main.
// All writes from the recursion appear as Load events.
static mut CELLS: [i32; 8] = [0; 8];

// Rust resolves mutual calls without forward declarations.
#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_even(d: usize) {
    if d >= 8 { return; }
    CELLS[d] = (d as i32) * 2;
    host_odd(d + 1);
}

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_odd(d: usize) {
    if d >= 8 { return; }
    CELLS[d] = (d as i32) * 2 + 1;
    host_even(d + 1);
}

static mut SUM: i32 = 0;

fn main() {
    unsafe {
        host_even(0); // IC;host_even  [mutual recursion invisible]  IR;host_even
        let mut s = 0i32;
        let mut i = 0usize;
        while i < 8 { s += CELLS[i]; i += 1; } // 8 Load events
        SUM = s; // 0+3+4+7+8+11+12+15 = wait: 0,3,4,7,8,11,12,15 — each i*2 or i*2+1
        // i=0:0, i=1:3, i=2:4, i=3:7, i=4:8, i=5:11, i=6:12, i=7:15 → sum=60
    }
}
