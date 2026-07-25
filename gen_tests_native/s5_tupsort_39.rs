fn main() {
    let mut v: Vec<(i32, i32)> = Vec::new();
    for i in 0..18i32 {
        v.push(((3 + i * 5) % 17, i));
    }
    v.sort_by_key(|&(a, _)| a);
    let names: Vec<i32> = v.iter().map(|&(a, _)| a).collect();
    println!("s5_tupsort_39 sorted_keys={:?}", names);
    v.sort_by(|a, b| b.0.cmp(&a.0));
    println!("desc_first={:?}", v.first());
}
