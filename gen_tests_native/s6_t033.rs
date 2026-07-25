
enum List {
    Cons(i64, Box<List>),
    Nil,
}

fn sum_list(l: &List) -> i64 {
    match l {
        List::Cons(v, rest) => v.wrapping_add(sum_list(rest)),
        List::Nil => 0,
    }
}

fn build(n: u32, seed: u32) -> List {
    let mut state = seed | 1;
    let mut lst = List::Nil;
    for i in 0..n {
        let mut x = state;
        x ^= x << 13; x ^= x >> 17; x ^= x << 5;
        state = x;
        let val = (x as i64).wrapping_mul((i as i64) + 1);
        lst = List::Cons(val, Box::new(lst));
    }
    lst
}

fn main() {
    println!("start s6_t033");
    let l = build(12, 962u32);
    let s = sum_list(&l);
    println!("sum={}", s);
}
