fn main(){
    println!("start o7_clos_109");
    let fs:Vec<Box<dyn Fn(i64)->i64>>=vec![
        Box::new(move |x:i64| x ^ 59586),
        Box::new(|x:i64| x.rotate_right(60)),
        Box::new(|x:i64| x.wrapping_add(53)),
        Box::new(move |x:i64| x.wrapping_sub(644))
    ];
    let mut v:i64=137327;
    for _ in 0..26 {
        for f in fs.iter() {
            v=f(v);
        }
        v&=0x00ff_ffff_ffff_ffff;
    }
    println!("v={} k={}",v,fs.len());
}
