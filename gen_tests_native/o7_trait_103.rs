trait Shape { fn val(&self, k:i64)->i64; }
struct A(i64); impl Shape for A { fn val(&self,k:i64)->i64{ self.0.wrapping_mul(k).wrapping_add(7) } }
struct B(i64); impl Shape for B { fn val(&self,k:i64)->i64{ self.0.wrapping_sub(k).wrapping_mul(94) } }
struct C(i64); impl Shape for C { fn val(&self,k:i64)->i64{ (self.0 ^ (k.wrapping_mul(6))).wrapping_add(472) } }
struct D(i64); impl Shape for D { fn val(&self,k:i64)->i64{ self.0.wrapping_add(k*k) } }
fn main(){
    println!("start o7_trait_103");
    let shapes:Vec<Box<dyn Shape>>=vec![Box::new(B(-489)),Box::new(D(186)),Box::new(D(-95)),Box::new(C(203)),Box::new(B(-402)),Box::new(A(5)),Box::new(B(-387)),Box::new(D(287)),Box::new(A(-218)),Box::new(C(343)),Box::new(A(-32)),Box::new(B(396)),Box::new(C(-139)),Box::new(A(355))];
    let mut acc:i64=580688;
    for _ in 0..5 {
        for (i,sh) in shapes.iter().enumerate() {
            acc=acc.wrapping_add(sh.val(i as i64 + 16));
            acc^=acc>>3;
        }
    }
    println!("acc={} n={}",acc,shapes.len());
}
