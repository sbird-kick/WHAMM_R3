fn main() {
    let v: Vec<i32> = (0..26).collect();
    let result: i64 = v.iter()
        .filter(|&&x| x % 4 != 0)
        .map(|&x| (x as i64) * (x as i64))
        .fold(0i64, |acc, x| acc + x);
    let evens: Vec<&i32> = v.iter().filter(|&&x| x % 2 == 0).collect();
    println!("s5_iterchain_25 result={} evens={}", result, evens.len());
}
