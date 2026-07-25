
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
    println!("start s6_t006");
    let ops = [Op::Mul(4681), Op::Sub(9363), Op::Xor(14045), Op::Mul(18727), Op::Sub(23409), Op::Xor(28091), Op::Mul(32773), Op::Sub(37455), Op::Xor(42137), Op::Mul(46819), Op::Sub(51501), Op::Xor(56183), Op::Mul(60865), Op::Sub(11), Op::Xor(4693), Op::Mul(9375), Op::Sub(14057), Op::Xor(18739), Op::Mul(23421), Op::Sub(28103), Op::Xor(32785), Op::Mul(37467), Op::Sub(42149), Op::Xor(46831)];
    
    let mut state: u32 = 4675u32 | 1;
    let mut buf: Box<[u32; 24]> = Box::new([0u32; 24]);
    let mut acc: u32 = 687u32;
    for (idx, op) in ops.iter().enumerate() {
        acc = apply(acc, op);
        let r = xorshift32(&mut state);
        let pos = (r as usize) % buf.len();
        buf[pos] = buf[pos].wrapping_add(r ^ (idx as u32));
    }
    
    let mut checksum: u64 = 0;
    for (idx, v) in buf.iter().enumerate() {
        checksum = checksum.wrapping_add((*v as u64).wrapping_mul((idx as u64) + 1));
    }
    println!("acc={} checksum={} state={}", acc, checksum, state);
}
