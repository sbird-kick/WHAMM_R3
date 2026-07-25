
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
    println!("start s6_t024");
    let ops = [Op::Add(16739), Op::Mul(33461), Op::Rot(50183), Op::Sub(1369), Op::Xor(18091), Op::Add(34813), Op::Mul(51535), Op::Rot(2721), Op::Sub(19443), Op::Xor(36165), Op::Add(52887), Op::Mul(4073), Op::Rot(20795), Op::Sub(37517), Op::Xor(54239), Op::Add(5425), Op::Mul(22147), Op::Rot(38869)];
    
    let mut state: u32 = 16715u32 | 1;
    let mut buf: Vec<u32> = vec![0u32; 18];
    let mut acc: u32 = 763u32;
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
