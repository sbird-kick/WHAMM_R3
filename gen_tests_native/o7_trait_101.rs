trait Shape { fn val(&self, k:i64)->i64; }
struct A(i64); impl Shape for A { fn val(&self,k:i64)->i64{ self.0.wrapping_mul(k).wrapping_add(81) } }
struct B(i64); impl Shape for B { fn val(&self,k:i64)->i64{ self.0.wrapping_sub(k).wrapping_mul(8) } }
struct C(i64); impl Shape for C { fn val(&self,k:i64)->i64{ (self.0 ^ (k.wrapping_mul(915))).wrapping_add(365) } }
struct D(i64); impl Shape for D { fn val(&self,k:i64)->i64{ self.0.wrapping_add(k*k) } }
struct E(i64); impl Shape for E { fn val(&self,k:i64)->i64{ self.0.rotate_left((k as u32)&31) as i64 } }
fn main(){
    println!("start o7_trait_101");
    let shapes:Vec<Box<dyn Shape>>=vec![Box::new(D(-429)),Box::new(E(-350)),Box::new(E(-27)),Box::new(D(476)),Box::new(C(-282)),Box::new(B(100)),Box::new(E(185)),Box::new(D(189)),Box::new(E(230)),Box::new(D(125)),Box::new(C(333)),Box::new(A(146)),Box::new(D(-58))];
    let mut acc:i64=769100;
    for _ in 0..7 {
        for (i,sh) in shapes.iter().enumerate() {
            acc=acc.wrapping_add(sh.val(i as i64 + 41));
            acc^=acc>>3;
        }
    }
    println!("acc={} n={}",acc,shapes.len());
}
