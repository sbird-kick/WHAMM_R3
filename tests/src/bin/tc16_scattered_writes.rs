// TC16: host writes to non-contiguous addresses (large gaps between them).
// Verifies Load events appear at the correct scattered addresses.
static mut PAGE: [i32; 64] = [0; 64];
static mut OUT: [i32; 4] = [0; 4];

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_scatter() {
    PAGE[0]  = 11;
    PAGE[15] = 22;
    PAGE[31] = 33;
    PAGE[63] = 44;
}

fn main() {
    unsafe {
        host_scatter();
        OUT[0] = PAGE[0];   // L at PAGE+0
        OUT[1] = PAGE[15];  // L at PAGE+60
        OUT[2] = PAGE[31];  // L at PAGE+124
        OUT[3] = PAGE[63];  // L at PAGE+252
    }
}
