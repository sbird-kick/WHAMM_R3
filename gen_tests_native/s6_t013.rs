
fn xorshift32(state: &mut u32) -> u32 {
    let mut x = *state;
    x ^= x << 13;
    x ^= x >> 17;
    x ^= x << 5;
    *state = x;
    x
}

enum Op { Add(u32), Sub(u32), Mul(u32), Xor(u32), Rot(u32) }

fn apply(acc: u32, op: &Op) -> u32 {
    match op {
        Op::Add(k) => acc.wrapping_add(*k),
            Op::Sub(k) => acc.wrapping_sub(*k),
            Op::Mul(k) => acc.wrapping_mul(*k | 1),
            Op::Xor(k) => acc ^ *k,
            Op::Rot(k) => acc.rotate_left(*k % 31),
    }
}

fn main() {
    println!("start s6_t013");
    let ops = [Op::Xor(9376), Op::Xor(18746), Op::Add(28116), Op::Xor(37486), Op::Xor(46856), Op::Add(56226), Op::Xor(60), Op::Xor(9430), Op::Add(18800), Op::Xor(28170), Op::Xor(37540), Op::Add(46910), Op::Xor(56280), Op::Xor(114), Op::Add(9484), Op::Xor(18854), Op::Xor(28224), Op::Add(37594), Op::Xor(46964), Op::Xor(56334), Op::Add(168), Op::Xor(9538), Op::Xor(18908), Op::Add(28278), Op::Xor(37648)];
    let shared: std::rc::Rc<Vec<u32>> = std::rc::Rc::new((0..8u32).collect());
    let shared2 = std::rc::Rc::clone(&shared);
    let rc_sum: u64 = shared2.iter().map(|x| *x as u64).sum();
    let mut state: u32 = 9363u32 | 1;
    let mut buf: Box<[u32; 25]> = Box::new([0u32; 25]);
    let mut acc: u32 = 390u32;
    for (idx, op) in ops.iter().enumerate() {
        acc = apply(acc, op);
        let r = xorshift32(&mut state);
        let pos = (r as usize) % buf.len();
        buf[pos] = buf[pos].wrapping_add(r ^ (idx as u32));
    }
    acc = acc.wrapping_add(rc_sum as u32);
    let mut checksum: u64 = 0;
    for (idx, v) in buf.iter().enumerate() {
        checksum = checksum.wrapping_add((*v as u64).wrapping_mul((idx as u64) + 1));
    }
    println!("acc={} checksum={} state={}", acc, checksum, state);
}
