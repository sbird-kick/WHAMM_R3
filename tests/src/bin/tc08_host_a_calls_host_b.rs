// TC08: host_outer calls host_inner (both excluded). From R3's view: one IC/IR
// for host_outer; host_inner is completely invisible. But writes from both
// appear as Load events when wasm reads.
// Expect: IC IR  then  L L
static mut X: i32 = 0;
static mut Y: i32 = 0;

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_inner(v: i32) {
    Y = v; // writes Y (invisible inner call)
}

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_outer(v: i32) {
    X = v;
    host_inner(v * 2); // excluded→excluded: no extra IC/IR
}

static mut OUT: [i32; 2] = [0; 2];

fn main() {
    unsafe {
        host_outer(5);
        OUT[0] = X; // L: 5
        OUT[1] = Y; // L: 10
    }
}
