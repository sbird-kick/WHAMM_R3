
use std::rc::Rc;

#[derive(Clone)]
enum Tree {
    Leaf(i32),
    Node(Rc<Tree>, Rc<Tree>),
}

fn eval(t: &Tree) -> i32 {
    match t {
        Tree::Leaf(v) => *v,
        Tree::Node(l, r) => eval(l).wrapping_add(eval(r)),
    }
}

fn xs(state: &mut u32) -> u32 {
    let mut x = *state;
    x ^= x << 13; x ^= x >> 17; x ^= x << 5;
    *state = x;
    x
}

fn main() {
    println!("start s6_t041");
    let mut state: u32 = 2074u32 | 1;
    let mut leaves: Vec<Rc<Tree>> = Vec::new();
    for i in 0..11 {
        let r = xs(&mut state);
        leaves.push(Rc::new(Tree::Leaf((r as i32).wrapping_add(i))));
    }
    let mut cur = leaves[0].clone();
    for i in 1..leaves.len() {
        cur = Rc::new(Tree::Node(cur, leaves[i].clone()));
    }
    let v = eval(&cur);
    println!("val={} rc_strong={}", v, Rc::strong_count(&leaves[0]));
}
