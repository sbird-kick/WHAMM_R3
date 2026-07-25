fn main() {
    let v: Vec<i32> = (0..34).collect();
    let result: i64 = v.iter()
        .filter(|&&x| x % 3 != 0)
        .map(|&x| (x as i64) * (x as i64))
        .fold(0i64, |acc, x| acc + x);
    let evens: Vec<&i32> = v.iter().filter(|&&x| x % 2 == 0).collect();
    println!("s5_iterchain_26 result={} evens={}", result, evens.len());
}
