// TC21: host fills a 3×3 matrix (row-major), wasm reads the diagonal.
// 3 Load events (diagonal elements only), not 9.
static mut MAT: [i32; 9] = [0; 9]; // 3×3 row-major

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_fill_matrix(rows: usize, cols: usize) {
    let mut r = 0usize;
    while r < rows {
        let mut c = 0usize;
        while c < cols {
            MAT[r * cols + c] = (r * cols + c + 1) as i32;
            c += 1;
        }
        r += 1;
    }
}

static mut DIAG_SUM: i32 = 0;

fn main() {
    unsafe {
        host_fill_matrix(3, 3);
        // MAT = [1,2,3, 4,5,6, 7,8,9]
        // Diagonal: MAT[0]=1, MAT[4]=5, MAT[8]=9
        DIAG_SUM = MAT[0] + MAT[4] + MAT[8]; // 3 Load events
    }
}
