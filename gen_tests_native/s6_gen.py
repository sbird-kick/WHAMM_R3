#!/usr/bin/env python3
import os

SEED = 666
PREFIX = "s6_"

# Variant templates: each returns rust source given index i and rng-derived params.

def xorshift_block(seed_const):
    return f"""
fn xorshift32(state: &mut u32) -> u32 {{
    let mut x = *state;
    x ^= x << 13;
    x ^= x >> 17;
    x ^= x << 5;
    *state = x;
    x
}}
"""

def mk_enum_buffer(i, params):
    seed_const, n, variants_order, use_box, use_rc = params
    name = f"{PREFIX}t{i:03d}"
    # enum with match, wrapping arithmetic
    variants = ["Add(u32)", "Sub(u32)", "Mul(u32)", "Xor(u32)", "Rot(u32)"]
    order = variants_order
    variant_defs = ", ".join(variants)
    enum_def = f"enum Op {{ {variant_defs} }}"

    match_arms = []
    for v in ["Add", "Sub", "Mul", "Xor", "Rot"]:
        if v == "Add":
            match_arms.append("Op::Add(k) => acc.wrapping_add(*k),")
        elif v == "Sub":
            match_arms.append("Op::Sub(k) => acc.wrapping_sub(*k),")
        elif v == "Mul":
            match_arms.append("Op::Mul(k) => acc.wrapping_mul(*k | 1),")
        elif v == "Xor":
            match_arms.append("Op::Xor(k) => acc ^ *k,")
        elif v == "Rot":
            match_arms.append("Op::Rot(k) => acc.rotate_left(*k % 31),")
    match_body = "\n            ".join(match_arms)

    # choose op sequence deterministically from order list of length n
    op_picks = []
    for j in range(n):
        v = order[j % len(order)]
        op_picks.append(v)

    ops_lines = []
    for j, v in enumerate(op_picks):
        k = (seed_const * (j + 1) + j * 7 + i) & 0xFFFF
        ops_lines.append(f"Op::{v}({k})")
    ops_array = ", ".join(ops_lines)

    if use_box:
        buf_decl = f"let mut buf: Box<[u32; {max(4,n)}]> = Box::new([0u32; {max(4,n)}]);"
    else:
        buf_decl = f"let mut buf: Vec<u32> = vec![0u32; {max(4,n)}];"

    if use_rc:
        rc_decl = "let shared: std::rc::Rc<Vec<u32>> = std::rc::Rc::new((0..8u32).collect());\n    let shared2 = std::rc::Rc::clone(&shared);\n    let rc_sum: u64 = shared2.iter().map(|x| *x as u64).sum();"
        rc_use = "acc = acc.wrapping_add(rc_sum as u32);"
    else:
        rc_decl = ""
        rc_use = ""

    src = f"""{xorshift_block(seed_const)}
{enum_def}

fn apply(acc: u32, op: &Op) -> u32 {{
    match op {{
        {match_body}
    }}
}}

fn main() {{
    println!("start {name}");
    let ops = [{ops_array}];
    {rc_decl}
    let mut state: u32 = {seed_const}u32 | 1;
    {buf_decl}
    let mut acc: u32 = {seed_const % 997}u32;
    for (idx, op) in ops.iter().enumerate() {{
        acc = apply(acc, op);
        let r = xorshift32(&mut state);
        let pos = (r as usize) % buf.len();
        buf[pos] = buf[pos].wrapping_add(r ^ (idx as u32));
    }}
    {rc_use}
    let mut checksum: u64 = 0;
    for (idx, v) in buf.iter().enumerate() {{
        checksum = checksum.wrapping_add((*v as u64).wrapping_mul((idx as u64) + 1));
    }}
    println!("acc={{}} checksum={{}} state={{}}", acc, checksum, state);
}}
"""
    return name, src


def mk_boxed_list(i, params):
    seed_const, depth = params
    name = f"{PREFIX}t{i:03d}"
    src = f"""
enum List {{
    Cons(i64, Box<List>),
    Nil,
}}

fn sum_list(l: &List) -> i64 {{
    match l {{
        List::Cons(v, rest) => v.wrapping_add(sum_list(rest)),
        List::Nil => 0,
    }}
}}

fn build(n: u32, seed: u32) -> List {{
    let mut state = seed | 1;
    let mut lst = List::Nil;
    for i in 0..n {{
        let mut x = state;
        x ^= x << 13; x ^= x >> 17; x ^= x << 5;
        state = x;
        let val = (x as i64).wrapping_mul((i as i64) + 1);
        lst = List::Cons(val, Box::new(lst));
    }}
    lst
}}

fn main() {{
    println!("start {name}");
    let l = build({depth}, {seed_const}u32);
    let s = sum_list(&l);
    println!("sum={{}}", s);
}}
"""
    return name, src


def mk_rc_tree(i, params):
    seed_const, nodes = params
    name = f"{PREFIX}t{i:03d}"
    src = f"""
use std::rc::Rc;

#[derive(Clone)]
enum Tree {{
    Leaf(i32),
    Node(Rc<Tree>, Rc<Tree>),
}}

fn eval(t: &Tree) -> i32 {{
    match t {{
        Tree::Leaf(v) => *v,
        Tree::Node(l, r) => eval(l).wrapping_add(eval(r)),
    }}
}}

fn xs(state: &mut u32) -> u32 {{
    let mut x = *state;
    x ^= x << 13; x ^= x >> 17; x ^= x << 5;
    *state = x;
    x
}}

fn main() {{
    println!("start {name}");
    let mut state: u32 = {seed_const}u32 | 1;
    let mut leaves: Vec<Rc<Tree>> = Vec::new();
    for i in 0..{nodes} {{
        let r = xs(&mut state);
        leaves.push(Rc::new(Tree::Leaf((r as i32).wrapping_add(i))));
    }}
    let mut cur = leaves[0].clone();
    for i in 1..leaves.len() {{
        cur = Rc::new(Tree::Node(cur, leaves[i].clone()));
    }}
    let v = eval(&cur);
    println!("val={{}} rc_strong={{}}", v, Rc::strong_count(&leaves[0]));
}}
"""
    return name, src


def mk_prng_buffer_state_machine(i, params):
    seed_const, n = params
    name = f"{PREFIX}t{i:03d}"
    src = f"""
enum St {{ A, B, C }}

fn step(s: St, x: u32) -> (St, u32) {{
    match s {{
        St::A => if x % 3 == 0 {{ (St::B, x.wrapping_add(1)) }} else {{ (St::A, x.wrapping_mul(3).wrapping_add(1)) }},
        St::B => if x % 5 == 0 {{ (St::C, x.wrapping_sub(7)) }} else {{ (St::B, x.rotate_left(3)) }},
        St::C => (St::A, x ^ 0x9E3779B9u32),
    }}
}}

fn main() {{
    println!("start {name}");
    let mut state: u32 = {seed_const}u32 | 1;
    let mut buf = [0u32; {max(4,n)}];
    let mut s = St::A;
    let mut x: u32 = {seed_const % 251};
    for idx in 0..{n} {{
        x ^= x << 13; x ^= x >> 17; x ^= x << 5;
        let (ns, nx) = step(s, x);
        s = ns; x = nx;
        buf[idx % buf.len()] = buf[idx % buf.len()].wrapping_add(x);
    }}
    let total: u64 = buf.iter().map(|v| *v as u64).sum();
    println!("total={{}} x={{}}", total, x);
}}
"""
    return name, src


tests = []
i = 0

# Group A: enum-op buffer, varying params (18 tests)
orders = [
    ["Add","Xor","Rot"], ["Mul","Sub","Xor"], ["Rot","Add","Mul","Xor"],
    ["Xor","Xor","Add"], ["Sub","Rot","Mul"], ["Add","Mul","Rot","Sub","Xor"],
]
for oi, order in enumerate(orders):
    for use_box in [True, False]:
        for use_rc in [True, False]:
            i += 1
            n = 6 + (i * 3) % 20
            seed_const = (SEED * (i+1) + oi*13) & 0xFFFF
            tests.append(mk_enum_buffer(i, (seed_const, n, order, use_box, use_rc)))

# Group B: boxed linked list sum (12 tests)
for j in range(12):
    i += 1
    depth = 5 + (j * 4) % 25
    seed_const = (SEED + j * 37) & 0xFFFF
    tests.append(mk_boxed_list(i, (seed_const, depth)))

# Group C: Rc tree eval (12 tests)
for j in range(12):
    i += 1
    nodes = 3 + (j * 2) % 10
    seed_const = (SEED * 3 + j * 19) & 0xFFFF
    tests.append(mk_rc_tree(i, (seed_const, nodes)))

# Group D: state machine + prng buffer (10 tests)
for j in range(10):
    i += 1
    n = 8 + (j * 5) % 30
    seed_const = (SEED * 7 + j * 41) & 0xFFFF
    tests.append(mk_prng_buffer_state_machine(i, (seed_const, n)))

outdir = "/Users/humza/Downloads/claude-play-space/WHAMM_R3/gen_tests_native"
names = []
for name, src in tests:
    path = os.path.join(outdir, name + ".rs")
    with open(path, "w") as f:
        f.write(src)
    names.append(name)

print(len(names), "files written")
print("\n".join(names))
