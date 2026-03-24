// TC01: single host write, wasm reads it.
// Simplest possible pattern: IC IR L
static mut BUF: i32 = 0;

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_set(val: i32) { BUF = val; }

fn main() {
    unsafe {
        host_set(42);
        let _ = BUF; // Load event: BUF = 42
    }
}
