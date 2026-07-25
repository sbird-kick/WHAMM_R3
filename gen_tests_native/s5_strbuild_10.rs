fn main() {
    let mut s = String::new();
    for i in 0..11 {
        s.push_str(&format!("[{}:{}]", i, i * 7));
    }
    let upper = s.to_uppercase();
    let rev: String = s.chars().rev().collect();
    println!("s5_strbuild_10 s={}", s);
    println!("upper_len={} rev_len={}", upper.len(), rev.len());
}
