fn main(){
    println!("start o7_clos_114");
    let fs:Vec<Box<dyn Fn(i64)->i64>>=vec![
        Box::new(move |x:i64| x.wrapping_sub(19)),
        Box::new(|x:i64| x.wrapping_mul(x).wrapping_add(1)),
        Box::new(|x:i64| x.rotate_right(17)),
        Box::new(|x:i64| x.wrapping_add(908)),
        Box::new(|x:i64| x.wrapping_mul(7))
    ];
    let mut v:i64=768504;
    for _ in 0..57 {
        for f in fs.iter() {
            v=f(v);
        }
        v&=0x00ff_ffff_ffff_ffff;
    }
    println!("v={} k={}",v,fs.len());
}
