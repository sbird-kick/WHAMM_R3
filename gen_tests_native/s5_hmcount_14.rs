use std::collections::HashMap;
fn main() {
    let words = ["fly", "hen", "dog", "owl", "dog", "fly", "elk", "owl", "bee", "emu", "emu", "fly", "hen", "yak"];
    let mut m: HashMap<&str, i32> = HashMap::new();
    for w in words.iter() {
        *m.entry(w).or_insert(0) += 1;
    }
    let mut pairs: Vec<(&str, i32)> = m.into_iter().collect();
    pairs.sort_by(|a, b| a.0.cmp(b.0));
    println!("s5_hmcount_14 pairs={:?}", pairs);
    let total: i32 = pairs.iter().map(|p| p.1).sum();
    println!("total={}", total);
}
