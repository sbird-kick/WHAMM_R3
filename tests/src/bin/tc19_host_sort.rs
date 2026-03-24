// TC19: wasm fills an array in reverse order, host sorts it (bubble sort),
// wasm reads the sorted result. All reads trigger Load events (shadow still 0).
static mut ARR: [i32; 8] = [0; 8];
static mut OUT: [i32; 8] = [0; 8];

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_sort() {
    // Bubble sort ARR[0..8]
    let n = 8usize;
    let mut i = 0usize;
    while i < n {
        let mut j = 0usize;
        while j < n - i - 1 {
            if ARR[j] > ARR[j+1] {
                let tmp = ARR[j]; ARR[j] = ARR[j+1]; ARR[j+1] = tmp;
            }
            j += 1;
        }
        i += 1;
    }
}

fn main() {
    unsafe {
        // Wasm writes reverse: [8,7,6,5,4,3,2,1]
        let mut i = 0usize;
        while i < 8 { ARR[i] = (8 - i) as i32; i += 1; }

        host_sort(); // host sorts in place

        // Wasm reads sorted result
        let mut i = 0usize;
        while i < 8 { OUT[i] = ARR[i]; i += 1; } // 8 Load events: [1,2,3,4,5,6,7,8]
    }
}
