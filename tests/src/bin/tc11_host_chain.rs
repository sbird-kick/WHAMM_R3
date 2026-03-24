// TC11: host_a → host_b → host_c (all excluded, all invisible to R3).
// One IC/IR pair for host_a; the chain is opaque; all three cells appear
// as Load events.
static mut X: i32 = 0;
static mut Y: i32 = 0;
static mut Z: i32 = 0;

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_c(v: i32) { Z = v; }

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_b(v: i32) {
    Y = v;
    host_c(v + 10); // invisible
}

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_a(v: i32) {
    X = v;
    host_b(v + 5); // invisible
}

static mut OUT: [i32; 3] = [0; 3];

fn main() {
    unsafe {
        host_a(1);      // one IC;host_a  IR;host_a
        OUT[0] = X;     // L: 1
        OUT[1] = Y;     // L: 6
        OUT[2] = Z;     // L: 16
    }
}
