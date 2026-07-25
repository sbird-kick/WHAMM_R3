
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
    println!("start s6_t018");
    let ops = [Op::Sub(12724), Op::Rot(25437), Op::Mul(38150), Op::Sub(50863), Op::Rot(63576), Op::Mul(10753), Op::Sub(23466), Op::Rot(36179), Op::Mul(48892), Op::Sub(61605), Op::Rot(8782), Op::Mul(21495), Op::Sub(34208), Op::Rot(46921), Op::Mul(59634), Op::Sub(6811), Op::Rot(19524), Op::Mul(32237), Op::Sub(44950), Op::Rot(57663)];
    
    let mut state: u32 = 12706u32 | 1;
    let mut buf: Box<[u32; 20]> = Box::new([0u32; 20]);
    let mut acc: u32 = 742u32;
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
