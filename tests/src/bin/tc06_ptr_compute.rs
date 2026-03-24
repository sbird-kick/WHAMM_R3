// TC06: host receives a raw pointer, computes a value, writes it there.
// Tests Load event for a stack-allocated variable.
// Expect: IC IR  then  L at stack address

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_compute_into(out: *mut i32, a: i32, b: i32) {
    *out = a * b + a + b; // (a+1)(b+1) - 1
}

static mut OUT: i32 = 0;

fn main() {
    unsafe {
        let mut result: i32 = 0;
        host_compute_into(&mut result as *mut i32, 5, 6);
        OUT = result; // L: 5*6+5+6 = 41
    }
}
