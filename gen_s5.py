import os, random

OUT = "/Users/humza/Downloads/claude-play-space/WHAMM_R3/gen_tests_native"
SEED = 555
rng = random.Random(SEED)

files = []

def add(name, code):
    files.append((name, code))

idx = 1
def nid():
    global idx
    n = idx
    idx += 1
    return n

# --- Category 1: Vec push/sort/dedup + format ---
for i in range(6):
    n = nid()
    name = f"s5_vecsort_{n}"
    sz = 12 + rng.randint(0, 20)
    mul = 3 + rng.randint(1, 9)
    md = 7 + rng.randint(0, 13)
    code = f'''fn main() {{
    let mut v: Vec<i64> = Vec::new();
    for i in 0..{sz}i64 {{
        v.push((i * {mul} + {i}) % {md} - {md/2:.0f});
    }}
    v.sort();
    v.dedup();
    let sum: i64 = v.iter().sum();
    println!("{name} sorted={{:?}}", v);
    println!("sum={{}} len={{}}", sum, v.len());
}}
'''
    add(name, code)

# --- Category 2: String building ---
for i in range(6):
    n = nid()
    name = f"s5_strbuild_{n}"
    cnt = 5 + rng.randint(0, 8)
    step = 2 + rng.randint(1, 5)
    code = f'''fn main() {{
    let mut s = String::new();
    for i in 0..{cnt} {{
        s.push_str(&format!("[{{}}:{{}}]", i, i * {step}));
    }}
    let upper = s.to_uppercase();
    let rev: String = s.chars().rev().collect();
    println!("{name} s={{}}", s);
    println!("upper_len={{}} rev_len={{}}", upper.len(), rev.len());
}}
'''
    add(name, code)

# --- Category 3: HashMap word count (sorted output) ---
words_pool = ["fox","dog","cat","owl","bee","ant","cow","pig","rat","elk","emu","yak","hen","fly","gnu"]
for i in range(6):
    n = nid()
    name = f"s5_hmcount_{n}"
    cnt = 10 + rng.randint(0, 10)
    chosen = [words_pool[rng.randint(0, len(words_pool)-1)] for _ in range(cnt)]
    words_lit = ", ".join(f'"{w}"' for w in chosen)
    code = f'''use std::collections::HashMap;
fn main() {{
    let words = [{words_lit}];
    let mut m: HashMap<&str, i32> = HashMap::new();
    for w in words.iter() {{
        *m.entry(w).or_insert(0) += 1;
    }}
    let mut pairs: Vec<(&str, i32)> = m.into_iter().collect();
    pairs.sort_by(|a, b| a.0.cmp(b.0));
    println!("{name} pairs={{:?}}", pairs);
    let total: i32 = pairs.iter().map(|p| p.1).sum();
    println!("total={{}}", total);
}}
'''
    add(name, code)

# --- Category 4: BTreeMap accumulate ---
for i in range(6):
    n = nid()
    name = f"s5_btmap_{n}"
    sz = 15 + rng.randint(0, 15)
    modk = 5 + rng.randint(0, 5)
    code = f'''use std::collections::BTreeMap;
fn main() {{
    let mut m: BTreeMap<i32, i64> = BTreeMap::new();
    for i in 0..{sz}i64 {{
        let key = (i % {modk}) as i32;
        *m.entry(key).or_insert(0) += i * 2 + 1;
    }}
    for (k, v) in m.iter() {{
        println!("k={{}} v={{}}", k, v);
    }}
    let total: i64 = m.values().sum();
    println!("{name} total={{}} keys={{}}", total, m.len());
}}
'''
    add(name, code)

# --- Category 5: iterator chain map/filter/fold ---
for i in range(6):
    n = nid()
    name = f"s5_iterchain_{n}"
    sz = 20 + rng.randint(0, 20)
    thr = 3 + rng.randint(0, 4)
    code = f'''fn main() {{
    let v: Vec<i32> = (0..{sz}).collect();
    let result: i64 = v.iter()
        .filter(|&&x| x % {thr} != 0)
        .map(|&x| (x as i64) * (x as i64))
        .fold(0i64, |acc, x| acc + x);
    let evens: Vec<&i32> = v.iter().filter(|&&x| x % 2 == 0).collect();
    println!("{name} result={{}} evens={{}}", result, evens.len());
}}
'''
    add(name, code)

# --- Category 6: slice sort_by / windows / chunks ---
for i in range(5):
    n = nid()
    name = f"s5_slicewin_{n}"
    sz = 10 + rng.randint(0, 10)
    w = 2 + rng.randint(0, 3)
    code = f'''fn main() {{
    let mut arr: [i32; {sz}] = [0; {sz}];
    for i in 0..{sz} {{
        arr[i] = ((i as i32) * 7 + {i}) % 23 - 11;
    }}
    arr.sort_unstable();
    let sums: Vec<i32> = arr.windows({w}).map(|w| w.iter().sum()).collect();
    let chunk_sums: Vec<i32> = arr.chunks({w}).map(|c| c.iter().sum()).collect();
    println!("{name} sums={{:?}}", sums);
    println!("chunk_sums={{:?}}", chunk_sums);
}}
'''
    add(name, code)

# --- Category 7: Vec of tuples sort_by_key ---
for i in range(5):
    n = nid()
    name = f"s5_tupsort_{n}"
    sz = 8 + rng.randint(0, 12)
    code = f'''fn main() {{
    let mut v: Vec<(i32, i32)> = Vec::new();
    for i in 0..{sz}i32 {{
        v.push((({i} + i * 5) % 17, i));
    }}
    v.sort_by_key(|&(a, _)| a);
    let names: Vec<i32> = v.iter().map(|&(a, _)| a).collect();
    println!("{name} sorted_keys={{:?}}", names);
    v.sort_by(|a, b| b.0.cmp(&a.0));
    println!("desc_first={{:?}}", v.first());
}}
'''
    add(name, code)

# --- Category 8: String split/join ---
for i in range(5):
    n = nid()
    name = f"s5_strsplit_{n}"
    sep = rng.choice([",", ";", "-", "|"])
    parts = 4 + rng.randint(0, 6)
    nums = [str(rng.randint(1, 99)) for _ in range(parts)]
    joined = sep.join(nums)
    code = f'''fn main() {{
    let data = "{joined}";
    let parts: Vec<&str> = data.split('{sep}').collect();
    let nums: Vec<i32> = parts.iter().map(|s| s.parse::<i32>().unwrap_or(0)).collect();
    let sum: i32 = nums.iter().sum();
    let joined2 = parts.join("_");
    println!("{name} nums={{:?}}", nums);
    println!("sum={{}} joined={{}}", sum, joined2);
}}
'''
    add(name, code)

# --- Category 9: HashMap entry API grouping ---
for i in range(5):
    n = nid()
    name = f"s5_hmgroup_{n}"
    sz = 12 + rng.randint(0, 10)
    modk = 3 + rng.randint(0, 4)
    code = f'''use std::collections::HashMap;
fn main() {{
    let mut groups: HashMap<i32, Vec<i32>> = HashMap::new();
    for i in 0..{sz}i32 {{
        let key = i % {modk};
        groups.entry(key).or_insert_with(Vec::new).push(i);
    }}
    let mut keys: Vec<&i32> = groups.keys().collect();
    keys.sort();
    for k in &keys {{
        println!("k={{}} v={{:?}}", k, groups[k]);
    }}
    println!("{name} ngroups={{}}", groups.len());
}}
'''
    add(name, code)

# --- Category 10: BTreeMap range/keys ---
for i in range(5):
    n = nid()
    name = f"s5_btrange_{n}"
    sz = 20 + rng.randint(0, 15)
    lo = 5 + rng.randint(0, 5)
    hi = lo + 8 + rng.randint(0, 5)
    code = f'''use std::collections::BTreeMap;
fn main() {{
    let mut m: BTreeMap<i32, i64> = BTreeMap::new();
    for i in 0..{sz}i32 {{
        m.insert(i, (i as i64) * (i as i64));
    }}
    let sub: Vec<(&i32, &i64)> = m.range({lo}..{hi}).collect();
    let sum: i64 = sub.iter().map(|&(_, v)| v).sum();
    println!("{name} sub_len={{}} sum={{}}", sub.len(), sum);
    let last = m.keys().last().unwrap();
    println!("last_key={{}}", last);
}}
'''
    add(name, code)

# --- Category 11: iterator zip/enumerate ---
for i in range(4):
    n = nid()
    name = f"s5_zipenum_{n}"
    sz = 10 + rng.randint(0, 10)
    code = f'''fn main() {{
    let a: Vec<i32> = (0..{sz}).map(|x| x * 2).collect();
    let b: Vec<i32> = (0..{sz}).map(|x| x * 3 + 1).collect();
    let zipped: Vec<i32> = a.iter().zip(b.iter()).map(|(&x, &y)| x + y).collect();
    let mut total = 0i64;
    for (idx, val) in zipped.iter().enumerate() {{
        total += (idx as i64) * (*val as i64);
    }}
    println!("{name} zipped={{:?}}", zipped);
    println!("total={{}}", total);
}}
'''
    add(name, code)

# --- Category 12: Vec retain/dedup_by ---
for i in range(4):
    n = nid()
    name = f"s5_retain_{n}"
    sz = 15 + rng.randint(0, 15)
    modv = 4 + rng.randint(0, 4)
    code = f'''fn main() {{
    let mut v: Vec<i32> = (0..{sz}).map(|x| x % {modv}).collect();
    v.retain(|&x| x != 0);
    v.dedup();
    v.push(999);
    v.sort();
    println!("{name} v={{:?}}", v);
    println!("len={{}}", v.len());
}}
'''
    add(name, code)

# --- Category 13: sort with reverse comparator + binary_search ---
for i in range(4):
    n = nid()
    name = f"s5_binsearch_{n}"
    sz = 16 + rng.randint(0, 10)
    target = 5 + rng.randint(0, 30)
    code = f'''fn main() {{
    let mut v: Vec<i32> = (0..{sz}).map(|x| x * 3 - 5).collect();
    v.sort();
    let target = {target};
    let res = v.binary_search(&target);
    v.sort_by(|a, b| b.cmp(a));
    println!("{name} first={{:?}} search={{:?}}", v.first(), res);
    println!("v={{:?}}", v);
}}
'''
    add(name, code)

# --- Category 14: String formatting width/precision ---
for i in range(4):
    n = nid()
    name = f"s5_fmtwidth_{n}"
    cnt = 5 + rng.randint(0, 5)
    code = f'''fn main() {{
    let mut out = String::new();
    for i in 0..{cnt} {{
        let v = (i as f64) * 1.5 + 0.25;
        out += &format!("{{:>6.2}}|", v);
    }}
    println!("{name} out={{}}", out);
    let hexed: Vec<String> = (0..{cnt}).map(|i| format!("{{:04x}}", i * 17)).collect();
    println!("hex={{:?}}", hexed);
}}
'''
    add(name, code)

# write all files
for name, code in files:
    path = os.path.join(OUT, f"{name}.rs")
    with open(path, "w") as f:
        f.write(code)

print(len(files))
for name, _ in files:
    print(name)
