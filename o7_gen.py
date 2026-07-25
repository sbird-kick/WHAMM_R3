#!/usr/bin/env python3
# o7_ generator: Rust advanced (trait objects, closures, BTreeMap, fmt, recursive Box, iterator chains)
import random, os
SEED=9707
OUT="gen_tests_native"
random.seed(SEED)

def rc(lo,hi): return random.randint(lo,hi)

tests={}

# ---- category 1: trait objects / dyn dispatch (call_indirect storms) ----
def gen_trait(n, idx):
    s=rc(1,1<<20)
    c0,c1,c2,c3=rc(2,99),rc(2,99),rc(1,999),rc(1,999)
    k=rc(1,50)
    nimpl=rc(3,5)
    impls="".join(
        [f"struct A(i64); impl Shape for A {{ fn val(&self,k:i64)->i64{{ self.0.wrapping_mul(k).wrapping_add({c0}) }} }}\n",
         f"struct B(i64); impl Shape for B {{ fn val(&self,k:i64)->i64{{ self.0.wrapping_sub(k).wrapping_mul({c1}) }} }}\n",
         f"struct C(i64); impl Shape for C {{ fn val(&self,k:i64)->i64{{ (self.0 ^ (k.wrapping_mul({c2}))).wrapping_add({c3}) }} }}\n",
         f"struct D(i64); impl Shape for D {{ fn val(&self,k:i64)->i64{{ self.0.wrapping_add(k*k) }} }}\n",
         f"struct E(i64); impl Shape for E {{ fn val(&self,k:i64)->i64{{ self.0.rotate_left((k as u32)&31) as i64 }} }}\n"][:nimpl])
    ctors=["A","B","C","D","E"][:nimpl]
    nvec=rc(6,14)
    vec=",".join(f"Box::new({random.choice(ctors)}({rc(-500,500)}))" for _ in range(nvec))
    loops=rc(3,9)
    src=f'''trait Shape {{ fn val(&self, k:i64)->i64; }}
{impls}fn main(){{
    println!("start {n}");
    let shapes:Vec<Box<dyn Shape>>=vec![{vec}];
    let mut acc:i64={s};
    for _ in 0..{loops} {{
        for (i,sh) in shapes.iter().enumerate() {{
            acc=acc.wrapping_add(sh.val(i as i64 + {k}));
            acc^=acc>>3;
        }}
    }}
    println!("acc={{}} n={{}}",acc,shapes.len());
}}
'''
    return src

# ---- category 2: closures captured in Vec<Box<dyn Fn>> ----
def gen_clos(n, idx):
    a,b,c=rc(2,50),rc(1,999),rc(1,1<<16)
    d,e=rc(1,63),rc(1,777)
    seed=rc(1,1<<20)
    nfns=rc(4,7)
    kinds=[
        f"Box::new(|x:i64| x.wrapping_mul({a}))",
        f"Box::new(|x:i64| x.wrapping_add({b}))",
        f"Box::new(move |x:i64| x ^ {c})",
        f"Box::new(|x:i64| x.rotate_right({d}))",
        f"Box::new(move |x:i64| x.wrapping_sub({e}))",
        f"Box::new(|x:i64| x.wrapping_mul(x).wrapping_add(1))",
        f"Box::new(|x:i64| (x>>2).wrapping_add(x<<1))",
    ]
    random.shuffle(kinds)
    fns=",\n        ".join(kinds[:nfns])
    iters=rc(20,80)
    src=f'''fn main(){{
    println!("start {n}");
    let fs:Vec<Box<dyn Fn(i64)->i64>>=vec![
        {fns}
    ];
    let mut v:i64={seed};
    for _ in 0..{iters} {{
        for f in fs.iter() {{
            v=f(v);
        }}
        v&=0x00ff_ffff_ffff_ffff;
    }}
    println!("v={{}} k={{}}",v,fs.len());
}}
'''
    return src

# ---- category 3: BTreeMap deterministic iteration ----
def gen_btree(n, idx):
    a,b=rc(3,97),rc(1,9999)
    p=rc(11,251)
    nn=rc(40,300)
    seed=rc(1,1<<20)
    src=f'''use std::collections::BTreeMap;
fn main(){{
    println!("start {n}");
    let mut m:BTreeMap<u64,i64>=BTreeMap::new();
    let mut x:u64={seed};
    for i in 0..{nn}u64 {{
        x=x.wrapping_mul({a}).wrapping_add({b});
        let key=(x>>7)%{p};
        *m.entry(key).or_insert(0)+=i as i64;
    }}
    let mut acc:i64=0;
    let mut first=0u64;
    for (idx,(k,val)) in m.iter().enumerate() {{
        if idx==0 {{ first=*k; }}
        acc=acc.wrapping_add((*k as i64).wrapping_mul(*val));
    }}
    let last=m.keys().last().copied().unwrap_or(0);
    println!("acc={{}} len={{}} first={{}} last={{}}",acc,m.len(),first,last);
}}
'''
    return src

# ---- category 4: string formatting machinery ----
def gen_fmt(n, idx):
    a,b=rc(3,97),rc(1,9999)
    nn=rc(20,120)
    w=rc(3,8)
    src=f'''use std::fmt::Write;
fn main(){{
    println!("start {n}");
    let mut s=String::new();
    for i in 0u64..{nn} {{
        let v=i.wrapping_mul({a}).wrapping_add({b});
        let _=write!(s,"{{:x}}|{{:>{w}}}|{{:08b}},",v,(i%13),(v&0xff));
    }}
    let chk:u64=s.bytes().map(|c| c as u64).fold(0u64,|a,c| a.wrapping_mul(31).wrapping_add(c));
    let commas=s.bytes().filter(|&c| c==b',').count();
    println!("len={{}} chk={{}} commas={{}}",s.len(),chk,commas);
}}
'''
    return src

# ---- category 5: recursive data via Box ----
def gen_rec(n, idx):
    depth=rc(8,13)
    k=rc(1,500)
    seed=rc(-1000,1000)
    m=rc(2,5)
    src=f'''enum Tree {{ Leaf(i64), Node(Box<Tree>,Box<Tree>) }}
fn build(d:u32,seed:i64)->Box<Tree> {{
    if d==0 {{ Box::new(Tree::Leaf(seed)) }}
    else {{ Box::new(Tree::Node(
        build(d-1,seed.wrapping_mul({m}).wrapping_add(1)),
        build(d-1,seed.wrapping_add({k})))) }}
}}
fn sum(t:&Tree)->i64 {{
    match t {{ Tree::Leaf(v)=>*v, Tree::Node(a,b)=>sum(a).wrapping_add(sum(b)) }}
}}
fn count(t:&Tree)->u64 {{
    match t {{ Tree::Leaf(_)=>1, Tree::Node(a,b)=>count(a)+count(b) }}
}}
fn main(){{
    println!("start {n}");
    let t=build({depth},{seed});
    println!("sum={{}} leaves={{}}",sum(&t),count(&t));
}}
'''
    return src

# ---- category 6: iterator adapter chains ----
def gen_iter(n, idx):
    a,b=rc(2,50),rc(1,999),
    nn=rc(50,300)
    seed=rc(1,1<<16)
    tk=rc(20,80)
    src=f'''fn main(){{
    println!("start {n}");
    let r=(0u64..{nn})
        .map(|x| x.wrapping_mul({a}).wrapping_add({b}))
        .filter(|v| v%3!=0)
        .scan(0u64,|st,v| {{ *st=st.wrapping_add(v); Some(*st) }})
        .take({tk})
        .fold({seed}u64,|acc,x| acc.wrapping_mul(2).wrapping_add(x^acc));
    let z:u64=(0u64..{nn}).zip((0u64..{nn}).rev())
        .map(|(p,q)| p.wrapping_mul(q))
        .filter(|v| v&1==0)
        .sum();
    println!("r={{}} z={{}}",r,z);
}}
'''
    return src

gens=[("trait",gen_trait),("clos",gen_clos),("btree",gen_btree),
      ("fmt",gen_fmt),("rec",gen_rec),("iter",gen_iter)]

num=100
per=9
for name,fn in gens:
    for j in range(per):
        tn=f"o7_{name}_{num}"
        tests[tn]=fn(tn,num)
        num+=1

for tn,src in tests.items():
    with open(os.path.join(OUT,tn+".rs"),"w") as f:
        f.write(src)
print(f"wrote {len(tests)} tests")
for tn in tests: print(tn)
