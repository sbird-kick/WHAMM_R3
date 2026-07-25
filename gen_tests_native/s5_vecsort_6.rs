fn main() {
    let mut v: Vec<i64> = Vec::new();
    for i in 0..16i64 {
        v.push((i * 4 + 5) % 14 - 7);
    }
    v.sort();
    v.dedup();
    let sum: i64 = v.iter().sum();
    println!("s5_vecsort_6 sorted={:?}", v);
    println!("sum={} len={}", sum, v.len());
}
