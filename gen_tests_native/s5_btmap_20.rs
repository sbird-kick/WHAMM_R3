use std::collections::BTreeMap;
fn main() {
    let mut m: BTreeMap<i32, i64> = BTreeMap::new();
    for i in 0..23i64 {
        let key = (i % 10) as i32;
        *m.entry(key).or_insert(0) += i * 2 + 1;
    }
    for (k, v) in m.iter() {
        println!("k={} v={}", k, v);
    }
    let total: i64 = m.values().sum();
    println!("s5_btmap_20 total={} keys={}", total, m.len());
}
