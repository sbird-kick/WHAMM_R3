fn main() {
    let mut v: Vec<i64> = Vec::new();
    for i in 0..15i64 {
        v.push((i * 6 + 2) % 11 - 6);
    }
    v.sort();
    v.dedup();
    let sum: i64 = v.iter().sum();
    println!("s5_vecsort_3 sorted={:?}", v);
    println!("sum={} len={}", sum, v.len());
}
