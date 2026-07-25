fn main(){
    println!("start o7_iter_150");
    let r=(0u64..55)
        .map(|x| x.wrapping_mul(33).wrapping_add(529))
        .filter(|v| v%3!=0)
        .scan(0u64,|st,v| { *st=st.wrapping_add(v); Some(*st) })
        .take(77)
        .fold(30990u64,|acc,x| acc.wrapping_mul(2).wrapping_add(x^acc));
    let z:u64=(0u64..55).zip((0u64..55).rev())
        .map(|(p,q)| p.wrapping_mul(q))
        .filter(|v| v&1==0)
        .sum();
    println!("r={} z={}",r,z);
}
