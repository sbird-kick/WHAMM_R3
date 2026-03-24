// TC02: host writes to multiple distinct addresses, wasm reads all.
// Expect: IC IR IC IR IC IR  then  L L L
static mut A: i32 = 0;
static mut B: i32 = 0;
static mut C: i32 = 0;

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_write_a(v: i32) { A = v; }
#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_write_b(v: i32) { B = v; }
#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_write_c(v: i32) { C = v; }

static mut OUT: [i32; 3] = [0; 3];

fn main() {
    unsafe {
        host_write_a(10);
        host_write_b(20);
        host_write_c(30);
        OUT[0] = A; // L: 10
        OUT[1] = B; // L: 20
        OUT[2] = C; // L: 30
    }
}
