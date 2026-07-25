
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
    println!("start s6_t004");
    let ops = [Op::Add(3334), Op::Xor(6671), Op::Rot(10008), Op::Add(13345), Op::Xor(16682), Op::Rot(20019), Op::Add(23356), Op::Xor(26693), Op::Rot(30030), Op::Add(33367), Op::Xor(36704), Op::Rot(40041), Op::Add(43378), Op::Xor(46715), Op::Rot(50052), Op::Add(53389), Op::Xor(56726), Op::Rot(60063)];
    
    let mut state: u32 = 3330u32 | 1;
    let mut buf: Vec<u32> = vec![0u32; 18];
    let mut acc: u32 = 339u32;
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
