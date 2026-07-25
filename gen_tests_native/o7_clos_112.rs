fn main(){
    println!("start o7_clos_112");
    let fs:Vec<Box<dyn Fn(i64)->i64>>=vec![
        Box::new(|x:i64| x.wrapping_mul(x).wrapping_add(1)),
        Box::new(move |x:i64| x.wrapping_sub(772)),
        Box::new(|x:i64| x.rotate_right(17)),
        Box::new(|x:i64| x.wrapping_mul(40)),
        Box::new(|x:i64| (x>>2).wrapping_add(x<<1)),
        Box::new(move |x:i64| x ^ 10917)
    ];
    let mut v:i64=114055;
    for _ in 0..29 {
        for f in fs.iter() {
            v=f(v);
        }
        v&=0x00ff_ffff_ffff_ffff;
    }
    println!("v={} k={}",v,fs.len());
}
