
enum St { A, B, C }

fn step(s: St, x: u32) -> (St, u32) {
    match s {
        St::A => if x % 3 == 0 { (St::B, x.wrapping_add(1)) } else { (St::A, x.wrapping_mul(3).wrapping_add(1)) },
        St::B => if x % 5 == 0 { (St::C, x.wrapping_sub(7)) } else { (St::B, x.rotate_left(3)) },
        St::C => (St::A, x ^ 0x9E3779B9u32),
    }
}

fn main() {
    println!("start s6_t049");
    let mut state: u32 = 4662u32 | 1;
    let mut buf = [0u32; 8];
    let mut s = St::A;
    let mut x: u32 = 144;
    for idx in 0..8 {
        x ^= x << 13; x ^= x >> 17; x ^= x << 5;
        let (ns, nx) = step(s, x);
        s = ns; x = nx;
        buf[idx % buf.len()] = buf[idx % buf.len()].wrapping_add(x);
    }
    let total: u64 = buf.iter().map(|v| *v as u64).sum();
    println!("total={} x={}", total, x);
}
