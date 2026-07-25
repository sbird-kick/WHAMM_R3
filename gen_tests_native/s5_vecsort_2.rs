fn main() {
    let mut v: Vec<i64> = Vec::new();
    for i in 0..16i64 {
        v.push((i * 12 + 1) % 18 - 9);
    }
    v.sort();
    v.dedup();
    let sum: i64 = v.iter().sum();
    println!("s5_vecsort_2 sorted={:?}", v);
    println!("sum={} len={}", sum, v.len());
}
