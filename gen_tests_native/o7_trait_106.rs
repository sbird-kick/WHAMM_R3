trait Shape { fn val(&self, k:i64)->i64; }
struct A(i64); impl Shape for A { fn val(&self,k:i64)->i64{ self.0.wrapping_mul(k).wrapping_add(48) } }
struct B(i64); impl Shape for B { fn val(&self,k:i64)->i64{ self.0.wrapping_sub(k).wrapping_mul(78) } }
struct C(i64); impl Shape for C { fn val(&self,k:i64)->i64{ (self.0 ^ (k.wrapping_mul(579))).wrapping_add(759) } }
fn main(){
    println!("start o7_trait_106");
    let shapes:Vec<Box<dyn Shape>>=vec![Box::new(A(74)),Box::new(A(219)),Box::new(A(-333)),Box::new(C(289)),Box::new(C(-324)),Box::new(C(-329)),Box::new(B(75)),Box::new(B(-189)),Box::new(A(493)),Box::new(C(306)),Box::new(A(-198)),Box::new(A(-435))];
    let mut acc:i64=626582;
    for _ in 0..7 {
        for (i,sh) in shapes.iter().enumerate() {
            acc=acc.wrapping_add(sh.val(i as i64 + 29));
            acc^=acc>>3;
        }
    }
    println!("acc={} n={}",acc,shapes.len());
}
