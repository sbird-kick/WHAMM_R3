fn main(){
    println!("start o7_clos_111");
    let fs:Vec<Box<dyn Fn(i64)->i64>>=vec![
        Box::new(move |x:i64| x ^ 35675),
        Box::new(move |x:i64| x.wrapping_sub(424)),
        Box::new(|x:i64| x.wrapping_mul(33)),
        Box::new(|x:i64| (x>>2).wrapping_add(x<<1))
    ];
    let mut v:i64=914520;
    for _ in 0..49 {
        for f in fs.iter() {
            v=f(v);
        }
        v&=0x00ff_ffff_ffff_ffff;
    }
    println!("v={} k={}",v,fs.len());
}
