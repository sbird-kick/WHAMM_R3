fn main(){
    println!("start o7_clos_110");
    let fs:Vec<Box<dyn Fn(i64)->i64>>=vec![
        Box::new(|x:i64| (x>>2).wrapping_add(x<<1)),
        Box::new(|x:i64| x.wrapping_add(193)),
        Box::new(|x:i64| x.wrapping_mul(18)),
        Box::new(move |x:i64| x.wrapping_sub(4))
    ];
    let mut v:i64=342936;
    for _ in 0..27 {
        for f in fs.iter() {
            v=f(v);
        }
        v&=0x00ff_ffff_ffff_ffff;
    }
    println!("v={} k={}",v,fs.len());
}
