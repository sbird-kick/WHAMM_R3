use std::collections::BTreeMap;
fn main() {
    let mut m: BTreeMap<i32, i64> = BTreeMap::new();
    for i in 0..24i32 {
        m.insert(i, (i as i64) * (i as i64));
    }
    let sub: Vec<(&i32, &i64)> = m.range(10..23).collect();
    let sum: i64 = sub.iter().map(|&(_, v)| v).sum();
    println!("s5_btrange_55 sub_len={} sum={}", sub.len(), sum);
    let last = m.keys().last().unwrap();
    println!("last_key={}", last);
}
