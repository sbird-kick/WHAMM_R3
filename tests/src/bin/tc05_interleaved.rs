// TC05: host write → wasm read → host write again → wasm read again.
// After first Load, shadow is updated. Second host write creates another mismatch.
// Expect: IC IR L  IC IR L  (two separate host→read cycles)
static mut CELL: i32 = 0;
static mut OUT: [i32; 2] = [0; 2];

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_update(val: i32) { CELL = val; }

fn main() {
    unsafe {
        host_update(11);
        OUT[0] = CELL; // L: 11  — shadow updated to 11

        host_update(22);
        OUT[1] = CELL; // L: 22  — shadow was 11, live is 22 → new Load event
    }
}
