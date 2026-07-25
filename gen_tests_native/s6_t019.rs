
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
    println!("start s6_t019");
    let ops = [Op::Sub(13391), Op::Rot(26770), Op::Mul(40149), Op::Sub(53528), Op::Rot(1371), Op::Mul(14750), Op::Sub(28129), Op::Rot(41508), Op::Mul(54887), Op::Sub(2730), Op::Rot(16109), Op::Mul(29488), Op::Sub(42867), Op::Rot(56246), Op::Mul(4089), Op::Sub(17468), Op::Rot(30847), Op::Mul(44226), Op::Sub(57605), Op::Rot(5448), Op::Mul(18827), Op::Sub(32206), Op::Rot(45585)];
    let shared: std::rc::Rc<Vec<u32>> = std::rc::Rc::new((0..8u32).collect());
    let shared2 = std::rc::Rc::clone(&shared);
    let rc_sum: u64 = shared2.iter().map(|x| *x as u64).sum();
    let mut state: u32 = 13372u32 | 1;
    let mut buf: Vec<u32> = vec![0u32; 23];
    let mut acc: u32 = 411u32;
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
