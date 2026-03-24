// TC18: wasm reads same address twice after one host write.
// First read triggers Load event and updates shadow.
// Second read finds shadow == live → NO second Load event.
static mut CELL: i32 = 0;
static mut OUT: [i32; 2] = [0; 2];

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_write_once(v: i32) { CELL = v; }

fn main() {
    unsafe {
        host_write_once(123);
        OUT[0] = CELL; // L: 123 — shadow updated to 123
        OUT[1] = CELL; // NO Load event — shadow == live (both 123)
    }
}
