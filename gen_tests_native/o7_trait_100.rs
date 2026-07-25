trait Shape { fn val(&self, k:i64)->i64; }
struct A(i64); impl Shape for A { fn val(&self,k:i64)->i64{ self.0.wrapping_mul(k).wrapping_add(40) } }
struct B(i64); impl Shape for B { fn val(&self,k:i64)->i64{ self.0.wrapping_sub(k).wrapping_mul(98) } }
struct C(i64); impl Shape for C { fn val(&self,k:i64)->i64{ (self.0 ^ (k.wrapping_mul(291))).wrapping_add(7) } }
fn main(){
    println!("start o7_trait_100");
    let shapes:Vec<Box<dyn Shape>>=vec![Box::new(C(447)),Box::new(A(303)),Box::new(C(-224)),Box::new(A(-332)),Box::new(B(196)),Box::new(C(-167)),Box::new(C(-35)),Box::new(A(234)),Box::new(B(441)),Box::new(B(435))];
    let mut acc:i64=138879;
    for _ in 0..9 {
        for (i,sh) in shapes.iter().enumerate() {
            acc=acc.wrapping_add(sh.val(i as i64 + 10));
            acc^=acc>>3;
        }
    }
    println!("acc={} n={}",acc,shapes.len());
}
