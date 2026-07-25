
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
    println!("start s6_t011");
    let ops = [Op::Rot(8029), Op::Add(16054), Op::Mul(24079), Op::Xor(32104), Op::Rot(40129), Op::Add(48154), Op::Mul(56179), Op::Xor(64204), Op::Rot(6693), Op::Add(14718), Op::Mul(22743), Op::Xor(30768), Op::Rot(38793), Op::Add(46818), Op::Mul(54843), Op::Xor(62868), Op::Rot(5357), Op::Add(13382), Op::Mul(21407)];
    let shared: std::rc::Rc<Vec<u32>> = std::rc::Rc::new((0..8u32).collect());
    let shared2 = std::rc::Rc::clone(&shared);
    let rc_sum: u64 = shared2.iter().map(|x| *x as u64).sum();
    let mut state: u32 = 8018u32 | 1;
    let mut buf: Vec<u32> = vec![0u32; 19];
    let mut acc: u32 = 42u32;
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
