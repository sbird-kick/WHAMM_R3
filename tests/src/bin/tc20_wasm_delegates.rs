// TC20: a non-host wasm function delegates all real computation to a host
// function via a pointer, then reads the result back.
// The non-host function itself is instrumented — its load generates a Load event.
static mut SCRATCH: [i32; 4] = [0; 4];

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_populate(buf: *mut i32, n: usize, seed: i32) {
    let mut i = 0usize;
    while i < n {
        *(buf.add(i)) = seed + i as i32;
        i += 1;
    }
}

#[inline(never)]
unsafe fn wasm_sum_delegate(seed: i32) -> i32 {
    host_populate(SCRATCH.as_mut_ptr(), 4, seed); // IC IR
    let mut s = 0i32;
    let mut i = 0usize;
    while i < 4 { s += SCRATCH[i]; i += 1; } // 4 Load events
    s
}

static mut RESULT: i32 = 0;

fn main() {
    unsafe {
        RESULT = wasm_sum_delegate(10); // 10+11+12+13 = 46
    }
}
