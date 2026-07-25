fn main() {
    let mut arr: [i32; 20] = [0; 20];
    for i in 0..20 {
        arr[i] = ((i as i32) * 7 + 1) % 23 - 11;
    }
    arr.sort_unstable();
    let sums: Vec<i32> = arr.windows(3).map(|w| w.iter().sum()).collect();
    let chunk_sums: Vec<i32> = arr.chunks(3).map(|c| c.iter().sum()).collect();
    println!("s5_slicewin_32 sums={:?}", sums);
    println!("chunk_sums={:?}", chunk_sums);
}
