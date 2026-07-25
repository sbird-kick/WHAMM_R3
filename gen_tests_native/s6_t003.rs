
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
    println!("start s6_t003");
    let ops = [Op::Add(2667), Op::Xor(5338), Op::Rot(8009), Op::Add(10680), Op::Xor(13351), Op::Rot(16022), Op::Add(18693), Op::Xor(21364), Op::Rot(24035), Op::Add(26706), Op::Xor(29377), Op::Rot(32048), Op::Add(34719), Op::Xor(37390), Op::Rot(40061)];
    let shared: std::rc::Rc<Vec<u32>> = std::rc::Rc::new((0..8u32).collect());
    let shared2 = std::rc::Rc::clone(&shared);
    let rc_sum: u64 = shared2.iter().map(|x| *x as u64).sum();
    let mut state: u32 = 2664u32 | 1;
    let mut buf: Vec<u32> = vec![0u32; 15];
    let mut acc: u32 = 670u32;
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
