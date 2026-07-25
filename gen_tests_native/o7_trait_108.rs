trait Shape { fn val(&self, k:i64)->i64; }
struct A(i64); impl Shape for A { fn val(&self,k:i64)->i64{ self.0.wrapping_mul(k).wrapping_add(45) } }
struct B(i64); impl Shape for B { fn val(&self,k:i64)->i64{ self.0.wrapping_sub(k).wrapping_mul(56) } }
struct C(i64); impl Shape for C { fn val(&self,k:i64)->i64{ (self.0 ^ (k.wrapping_mul(144))).wrapping_add(212) } }
struct D(i64); impl Shape for D { fn val(&self,k:i64)->i64{ self.0.wrapping_add(k*k) } }
fn main(){
    println!("start o7_trait_108");
    let shapes:Vec<Box<dyn Shape>>=vec![Box::new(D(88)),Box::new(A(437)),Box::new(C(330)),Box::new(C(-216)),Box::new(A(66)),Box::new(C(322)),Box::new(D(136)),Box::new(B(163)),Box::new(B(-56)),Box::new(C(-340)),Box::new(C(-343)),Box::new(D(248))];
    let mut acc:i64=1006584;
    for _ in 0..3 {
        for (i,sh) in shapes.iter().enumerate() {
            acc=acc.wrapping_add(sh.val(i as i64 + 19));
            acc^=acc>>3;
        }
    }
    println!("acc={} n={}",acc,shapes.len());
}
