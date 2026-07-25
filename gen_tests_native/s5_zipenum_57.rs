fn main() {
    let a: Vec<i32> = (0..18).map(|x| x * 2).collect();
    let b: Vec<i32> = (0..18).map(|x| x * 3 + 1).collect();
    let zipped: Vec<i32> = a.iter().zip(b.iter()).map(|(&x, &y)| x + y).collect();
    let mut total = 0i64;
    for (idx, val) in zipped.iter().enumerate() {
        total += (idx as i64) * (*val as i64);
    }
    println!("s5_zipenum_57 zipped={:?}", zipped);
    println!("total={}", total);
}
