// TC17: host swaps two values in memory. Wasm wrote them first (shadow = 0),
// host swaps (shadow still 0, live changed), wasm reads both → two Load events.
static mut PAIR: [i32; 2] = [0; 2];
static mut OUT: [i32; 2] = [0; 2];

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_swap() {
    let tmp = PAIR[0];
    PAIR[0] = PAIR[1];
    PAIR[1] = tmp;
}

fn main() {
    unsafe {
        PAIR[0] = 111; PAIR[1] = 222; // wasm writes (shadow stays 0)
        host_swap();                   // host swaps: PAIR=[222,111]
        OUT[0] = PAIR[0];             // L: 222
        OUT[1] = PAIR[1];             // L: 111
    }
}
