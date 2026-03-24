// TC15: host fills array with Fibonacci sequence, wasm reads it.
// One IC/IR, then 10 Load events.
static mut FIB: [i32; 10] = [0; 10];
static mut TOTAL: i32 = 0;

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_fibonacci() {
    FIB[0] = 0; FIB[1] = 1;
    let mut i = 2usize;
    while i < 10 { FIB[i] = FIB[i-1] + FIB[i-2]; i += 1; }
}

fn main() {
    unsafe {
        host_fibonacci();
        let mut s = 0i32;
        let mut i = 0usize;
        while i < 10 { s += FIB[i]; i += 1; }
        TOTAL = s; // 0+1+1+2+3+5+8+13+21+34 = 88
    }
}
