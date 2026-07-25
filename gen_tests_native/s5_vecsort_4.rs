fn main() {
    let mut v: Vec<i64> = Vec::new();
    for i in 0..25i64 {
        v.push((i * 7 + 3) % 15 - 8);
    }
    v.sort();
    v.dedup();
    let sum: i64 = v.iter().sum();
    println!("s5_vecsort_4 sorted={:?}", v);
    println!("sum={} len={}", sum, v.len());
}
