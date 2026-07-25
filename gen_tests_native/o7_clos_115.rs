fn main(){
    println!("start o7_clos_115");
    let fs:Vec<Box<dyn Fn(i64)->i64>>=vec![
        Box::new(|x:i64| x.wrapping_mul(11)),
        Box::new(|x:i64| x.wrapping_add(424)),
        Box::new(|x:i64| x.rotate_right(61)),
        Box::new(move |x:i64| x.wrapping_sub(45)),
        Box::new(|x:i64| (x>>2).wrapping_add(x<<1)),
        Box::new(move |x:i64| x ^ 35221),
        Box::new(|x:i64| x.wrapping_mul(x).wrapping_add(1))
    ];
    let mut v:i64=645124;
    for _ in 0..65 {
        for f in fs.iter() {
            v=f(v);
        }
        v&=0x00ff_ffff_ffff_ffff;
    }
    println!("v={} k={}",v,fs.len());
}
