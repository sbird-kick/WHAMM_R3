fn main(){
    println!("start o7_clos_116");
    let fs:Vec<Box<dyn Fn(i64)->i64>>=vec![
        Box::new(move |x:i64| x ^ 15310),
        Box::new(|x:i64| x.wrapping_mul(x).wrapping_add(1)),
        Box::new(|x:i64| x.rotate_right(37)),
        Box::new(move |x:i64| x.wrapping_sub(759)),
        Box::new(|x:i64| x.wrapping_add(356)),
        Box::new(|x:i64| x.wrapping_mul(37))
    ];
    let mut v:i64=636782;
    for _ in 0..52 {
        for f in fs.iter() {
            v=f(v);
        }
        v&=0x00ff_ffff_ffff_ffff;
    }
    println!("v={} k={}",v,fs.len());
}
