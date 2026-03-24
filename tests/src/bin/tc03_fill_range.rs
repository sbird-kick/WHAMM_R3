// TC03: host fills an array, wasm reads each element.
// Expect: IC IR  then N Load events (one per array element).
static mut ARR: [i32; 8] = [0; 8];

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_fill_array(val: i32) {
    let mut i = 0usize;
    while i < 8 { ARR[i] = val; i += 1; }
}

static mut SUM: i32 = 0;

fn main() {
    unsafe {
        host_fill_array(7);
        let mut s = 0i32;
        let mut i = 0usize;
        while i < 8 { s += ARR[i]; i += 1; } // 8 Load events
        SUM = s; // 56
    }
}
