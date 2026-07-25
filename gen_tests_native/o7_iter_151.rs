fn main(){
    println!("start o7_iter_151");
    let r=(0u64..256)
        .map(|x| x.wrapping_mul(27).wrapping_add(245))
        .filter(|v| v%3!=0)
        .scan(0u64,|st,v| { *st=st.wrapping_add(v); Some(*st) })
        .take(23)
        .fold(60532u64,|acc,x| acc.wrapping_mul(2).wrapping_add(x^acc));
    let z:u64=(0u64..256).zip((0u64..256).rev())
        .map(|(p,q)| p.wrapping_mul(q))
        .filter(|v| v&1==0)
        .sum();
    println!("r={} z={}",r,z);
}
