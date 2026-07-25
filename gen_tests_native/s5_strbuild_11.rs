fn main() {
    let mut s = String::new();
    for i in 0..9 {
        s.push_str(&format!("[{}:{}]", i, i * 5));
    }
    let upper = s.to_uppercase();
    let rev: String = s.chars().rev().collect();
    println!("s5_strbuild_11 s={}", s);
    println!("upper_len={} rev_len={}", upper.len(), rev.len());
}
