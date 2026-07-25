fn main() {
    let mut arr: [i32; 11] = [0; 11];
    for i in 0..11 {
        arr[i] = ((i as i32) * 7 + 4) % 23 - 11;
    }
    arr.sort_unstable();
    let sums: Vec<i32> = arr.windows(5).map(|w| w.iter().sum()).collect();
    let chunk_sums: Vec<i32> = arr.chunks(5).map(|c| c.iter().sum()).collect();
    println!("s5_slicewin_35 sums={:?}", sums);
    println!("chunk_sums={:?}", chunk_sums);
}
