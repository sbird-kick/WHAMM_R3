trait Shape { fn val(&self, k:i64)->i64; }
struct A(i64); impl Shape for A { fn val(&self,k:i64)->i64{ self.0.wrapping_mul(k).wrapping_add(10) } }
struct B(i64); impl Shape for B { fn val(&self,k:i64)->i64{ self.0.wrapping_sub(k).wrapping_mul(89) } }
struct C(i64); impl Shape for C { fn val(&self,k:i64)->i64{ (self.0 ^ (k.wrapping_mul(221))).wrapping_add(800) } }
struct D(i64); impl Shape for D { fn val(&self,k:i64)->i64{ self.0.wrapping_add(k*k) } }
fn main(){
    println!("start o7_trait_105");
    let shapes:Vec<Box<dyn Shape>>=vec![Box::new(B(-150)),Box::new(A(-297)),Box::new(A(31)),Box::new(C(111)),Box::new(C(449)),Box::new(A(-81)),Box::new(A(360)),Box::new(C(336)),Box::new(A(-151))];
    let mut acc:i64=747087;
    for _ in 0..9 {
        for (i,sh) in shapes.iter().enumerate() {
            acc=acc.wrapping_add(sh.val(i as i64 + 49));
            acc^=acc>>3;
        }
    }
    println!("acc={} n={}",acc,shapes.len());
}
