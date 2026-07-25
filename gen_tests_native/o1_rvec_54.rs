static R:[(u8,i32);21]=[(140,35),(16,-33),(16,-66),(145,7),(220,62),(44,-38),(67,70),(172,-57),(59,-76),(164,-79),(6,15),(138,18),(50,46),(84,-18),(74,5),(178,-55),(106,22),(193,-63),(181,-54),(230,66),(38,34)];
fn main(){
    println!("start o1_rvec_54");
    let mut v:Vec<i64>=Vec::new();
    for &(a,b) in R.iter() { v.push(a as i64 + b as i64 *3); }
    let s:i64=v.iter().sum();
    let mx=*v.iter().max().unwrap();
    println!("sum={} max={} len={}",s,mx,v.len());
}
