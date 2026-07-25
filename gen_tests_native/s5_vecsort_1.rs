fn main() {
    let mut v: Vec<i64> = Vec::new();
    for i in 0..18i64 {
        v.push((i * 8 + 0) % 9 - 4);
    }
    v.sort();
    v.dedup();
    let sum: i64 = v.iter().sum();
    println!("s5_vecsort_1 sorted={:?}", v);
    println!("sum={} len={}", sum, v.len());
}
