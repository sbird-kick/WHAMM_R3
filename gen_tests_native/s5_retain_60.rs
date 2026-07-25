fn main() {
    let mut v: Vec<i32> = (0..28).map(|x| x % 6).collect();
    v.retain(|&x| x != 0);
    v.dedup();
    v.push(999);
    v.sort();
    println!("s5_retain_60 v={:?}", v);
    println!("len={}", v.len());
}
