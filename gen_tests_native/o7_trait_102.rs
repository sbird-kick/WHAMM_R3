trait Shape { fn val(&self, k:i64)->i64; }
struct A(i64); impl Shape for A { fn val(&self,k:i64)->i64{ self.0.wrapping_mul(k).wrapping_add(18) } }
struct B(i64); impl Shape for B { fn val(&self,k:i64)->i64{ self.0.wrapping_sub(k).wrapping_mul(42) } }
struct C(i64); impl Shape for C { fn val(&self,k:i64)->i64{ (self.0 ^ (k.wrapping_mul(39))).wrapping_add(607) } }
fn main(){
    println!("start o7_trait_102");
    let shapes:Vec<Box<dyn Shape>>=vec![Box::new(A(-443)),Box::new(C(-91)),Box::new(B(172)),Box::new(A(-460)),Box::new(B(-427)),Box::new(B(241)),Box::new(A(-128)),Box::new(C(-475)),Box::new(C(-166)),Box::new(C(362)),Box::new(C(-119))];
    let mut acc:i64=664299;
    for _ in 0..3 {
        for (i,sh) in shapes.iter().enumerate() {
            acc=acc.wrapping_add(sh.val(i as i64 + 21));
            acc^=acc>>3;
        }
    }
    println!("acc={} n={}",acc,shapes.len());
}
