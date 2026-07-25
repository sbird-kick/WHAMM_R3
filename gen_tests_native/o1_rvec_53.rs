static R:[(u8,i32);15]=[(181,-90),(161,8),(111,-62),(108,-44),(73,-59),(116,72),(8,5),(93,67),(50,-57),(63,45),(20,-2),(135,62),(176,-31),(164,25),(48,61)];
fn main(){
    println!("start o1_rvec_53");
    let mut v:Vec<i64>=Vec::new();
    for &(a,b) in R.iter() { v.push(a as i64 + b as i64 *3); }
    let s:i64=v.iter().sum();
    let mx=*v.iter().max().unwrap();
    println!("sum={} max={} len={}",s,mx,v.len());
}
