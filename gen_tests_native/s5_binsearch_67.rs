fn main() {
    let mut v: Vec<i32> = (0..26).map(|x| x * 3 - 5).collect();
    v.sort();
    let target = 24;
    let res = v.binary_search(&target);
    v.sort_by(|a, b| b.cmp(a));
    println!("s5_binsearch_67 first={:?} search={:?}", v.first(), res);
    println!("v={:?}", v);
}
