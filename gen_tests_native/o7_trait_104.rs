trait Shape { fn val(&self, k:i64)->i64; }
struct A(i64); impl Shape for A { fn val(&self,k:i64)->i64{ self.0.wrapping_mul(k).wrapping_add(98) } }
struct B(i64); impl Shape for B { fn val(&self,k:i64)->i64{ self.0.wrapping_sub(k).wrapping_mul(88) } }
struct C(i64); impl Shape for C { fn val(&self,k:i64)->i64{ (self.0 ^ (k.wrapping_mul(514))).wrapping_add(919) } }
fn main(){
    println!("start o7_trait_104");
    let shapes:Vec<Box<dyn Shape>>=vec![Box::new(B(199)),Box::new(B(198)),Box::new(B(87)),Box::new(C(-240)),Box::new(A(-72)),Box::new(C(-93)),Box::new(B(-360)),Box::new(A(-377)),Box::new(C(264)),Box::new(C(172)),Box::new(A(-251)),Box::new(B(466)),Box::new(B(340))];
    let mut acc:i64=92063;
    for _ in 0..9 {
        for (i,sh) in shapes.iter().enumerate() {
            acc=acc.wrapping_add(sh.val(i as i64 + 12));
            acc^=acc>>3;
        }
    }
    println!("acc={} n={}",acc,shapes.len());
}
