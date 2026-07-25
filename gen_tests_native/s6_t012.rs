
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
    println!("start s6_t012");
    let ops = [Op::Rot(8696), Op::Add(17387), Op::Mul(26078), Op::Xor(34769), Op::Rot(43460), Op::Add(52151), Op::Mul(60842), Op::Xor(3997), Op::Rot(12688), Op::Add(21379), Op::Mul(30070), Op::Xor(38761), Op::Rot(47452), Op::Add(56143), Op::Mul(64834), Op::Xor(7989), Op::Rot(16680), Op::Add(25371), Op::Mul(34062), Op::Xor(42753), Op::Rot(51444), Op::Add(60135)];
    
    let mut state: u32 = 8684u32 | 1;
    let mut buf: Vec<u32> = vec![0u32; 22];
    let mut acc: u32 = 708u32;
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
