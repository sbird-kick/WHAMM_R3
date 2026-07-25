fn main() {
    let mut out = String::new();
    for i in 0..8 {
        let v = (i as f64) * 1.5 + 0.25;
        out += &format!("{:>6.2}|", v);
    }
    println!("s5_fmtwidth_71 out={}", out);
    let hexed: Vec<String> = (0..8).map(|i| format!("{:04x}", i * 17)).collect();
    println!("hex={:?}", hexed);
}
