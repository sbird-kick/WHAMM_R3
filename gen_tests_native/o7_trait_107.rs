trait Shape { fn val(&self, k:i64)->i64; }
struct A(i64); impl Shape for A { fn val(&self,k:i64)->i64{ self.0.wrapping_mul(k).wrapping_add(37) } }
struct B(i64); impl Shape for B { fn val(&self,k:i64)->i64{ self.0.wrapping_sub(k).wrapping_mul(61) } }
struct C(i64); impl Shape for C { fn val(&self,k:i64)->i64{ (self.0 ^ (k.wrapping_mul(634))).wrapping_add(80) } }
struct D(i64); impl Shape for D { fn val(&self,k:i64)->i64{ self.0.wrapping_add(k*k) } }
fn main(){
    println!("start o7_trait_107");
    let shapes:Vec<Box<dyn Shape>>=vec![Box::new(C(-356)),Box::new(B(59)),Box::new(D(-372)),Box::new(B(444)),Box::new(A(-282)),Box::new(D(103)),Box::new(D(300)),Box::new(A(-331)),Box::new(C(441)),Box::new(C(45)),Box::new(D(-190))];
    let mut acc:i64=112357;
    for _ in 0..8 {
        for (i,sh) in shapes.iter().enumerate() {
            acc=acc.wrapping_add(sh.val(i as i64 + 26));
            acc^=acc>>3;
        }
    }
    println!("acc={} n={}",acc,shapes.len());
}
