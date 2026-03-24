// TC04: wasm writes a value, host overwrites it, wasm reads the host value.
// Shadow never sees wasm's store (R3 doesn't track stores to shadow).
// Expect: IC IR  then  L with host's value (not wasm's).
static mut CELL: i32 = 0;

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_overwrite(val: i32) { CELL = val; }

static mut OUT: i32 = 0;

fn main() {
    unsafe {
        CELL = 1000;          // wasm store — shadow stays 0
        host_overwrite(9999); // host overwrites — shadow still 0, live = 9999
        OUT = CELL;           // L: value = 9999 (shadow 0 ≠ live 9999)
    }
}
