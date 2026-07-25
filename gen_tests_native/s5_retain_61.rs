fn main() {
    let mut v: Vec<i32> = (0..16).map(|x| x % 7).collect();
    v.retain(|&x| x != 0);
    v.dedup();
    v.push(999);
    v.sort();
    println!("s5_retain_61 v={:?}", v);
    println!("len={}", v.len());
}
