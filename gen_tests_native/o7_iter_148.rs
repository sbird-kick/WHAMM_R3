fn main(){
    println!("start o7_iter_148");
    let r=(0u64..116)
        .map(|x| x.wrapping_mul(8).wrapping_add(45))
        .filter(|v| v%3!=0)
        .scan(0u64,|st,v| { *st=st.wrapping_add(v); Some(*st) })
        .take(64)
        .fold(47059u64,|acc,x| acc.wrapping_mul(2).wrapping_add(x^acc));
    let z:u64=(0u64..116).zip((0u64..116).rev())
        .map(|(p,q)| p.wrapping_mul(q))
        .filter(|v| v&1==0)
        .sum();
    println!("r={} z={}",r,z);
}
