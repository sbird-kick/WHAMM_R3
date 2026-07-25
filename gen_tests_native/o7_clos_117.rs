fn main(){
    println!("start o7_clos_117");
    let fs:Vec<Box<dyn Fn(i64)->i64>>=vec![
        Box::new(move |x:i64| x ^ 20799),
        Box::new(move |x:i64| x.wrapping_sub(507)),
        Box::new(|x:i64| (x>>2).wrapping_add(x<<1)),
        Box::new(|x:i64| x.wrapping_add(197)),
        Box::new(|x:i64| x.rotate_right(55))
    ];
    let mut v:i64=95509;
    for _ in 0..51 {
        for f in fs.iter() {
            v=f(v);
        }
        v&=0x00ff_ffff_ffff_ffff;
    }
    println!("v={} k={}",v,fs.len());
}
