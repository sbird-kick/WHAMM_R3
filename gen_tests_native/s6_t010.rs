
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
    println!("start s6_t010");
    let ops = [Op::Rot(7362), Op::Add(14721), Op::Mul(22080), Op::Xor(29439), Op::Rot(36798), Op::Add(44157), Op::Mul(51516), Op::Xor(58875), Op::Rot(698), Op::Add(8057), Op::Mul(15416), Op::Xor(22775), Op::Rot(30134), Op::Add(37493), Op::Mul(44852), Op::Xor(52211)];
    
    let mut state: u32 = 7352u32 | 1;
    let mut buf: Box<[u32; 16]> = Box::new([0u32; 16]);
    let mut acc: u32 = 373u32;
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
