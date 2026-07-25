fn main() {
    let mut v: Vec<i64> = Vec::new();
    for i in 0..21i64 {
        v.push((i * 11 + 4) % 7 - 4);
    }
    v.sort();
    v.dedup();
    let sum: i64 = v.iter().sum();
    println!("s5_vecsort_5 sorted={:?}", v);
    println!("sum={} len={}", sum, v.len());
}
