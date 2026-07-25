use std::collections::BTreeMap;
fn main(){
    println!("start o7_btree_121");
    let mut m:BTreeMap<u64,i64>=BTreeMap::new();
    let mut x:u64=19915;
    for i in 0..47u64 {
        x=x.wrapping_mul(13).wrapping_add(4969);
        let key=(x>>7)%169;
        *m.entry(key).or_insert(0)+=i as i64;
    }
    let mut acc:i64=0;
    let mut first=0u64;
    for (idx,(k,val)) in m.iter().enumerate() {
        if idx==0 { first=*k; }
        acc=acc.wrapping_add((*k as i64).wrapping_mul(*val));
    }
    let last=m.keys().last().copied().unwrap_or(0);
    println!("acc={} len={} first={} last={}",acc,m.len(),first,last);
}
