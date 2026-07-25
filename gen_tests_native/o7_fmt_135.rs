use std::fmt::Write;
fn main(){
    println!("start o7_fmt_135");
    let mut s=String::new();
    for i in 0u64..73 {
        let v=i.wrapping_mul(76).wrapping_add(3260);
        let _=write!(s,"{:x}|{:>7}|{:08b},",v,(i%13),(v&0xff));
    }
    let chk:u64=s.bytes().map(|c| c as u64).fold(0u64,|a,c| a.wrapping_mul(31).wrapping_add(c));
    let commas=s.bytes().filter(|&c| c==b',').count();
    println!("len={} chk={} commas={}",s.len(),chk,commas);
}
