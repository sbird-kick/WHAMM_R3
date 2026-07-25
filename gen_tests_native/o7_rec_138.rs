enum Tree { Leaf(i64), Node(Box<Tree>,Box<Tree>) }
fn build(d:u32,seed:i64)->Box<Tree> {
    if d==0 { Box::new(Tree::Leaf(seed)) }
    else { Box::new(Tree::Node(
        build(d-1,seed.wrapping_mul(5).wrapping_add(1)),
        build(d-1,seed.wrapping_add(164)))) }
}
fn sum(t:&Tree)->i64 {
    match t { Tree::Leaf(v)=>*v, Tree::Node(a,b)=>sum(a).wrapping_add(sum(b)) }
}
fn count(t:&Tree)->u64 {
    match t { Tree::Leaf(_)=>1, Tree::Node(a,b)=>count(a)+count(b) }
}
fn main(){
    println!("start o7_rec_138");
    let t=build(11,-501);
    println!("sum={} leaves={}",sum(&t),count(&t));
}
