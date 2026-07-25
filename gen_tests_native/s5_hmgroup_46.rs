use std::collections::HashMap;
fn main() {
    let mut groups: HashMap<i32, Vec<i32>> = HashMap::new();
    for i in 0..14i32 {
        let key = i % 6;
        groups.entry(key).or_insert_with(Vec::new).push(i);
    }
    let mut keys: Vec<&i32> = groups.keys().collect();
    keys.sort();
    for k in &keys {
        println!("k={} v={:?}", k, groups[k]);
    }
    println!("s5_hmgroup_46 ngroups={}", groups.len());
}
