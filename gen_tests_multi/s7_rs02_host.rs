static mut COUNTER: i64 = 41;

#[no_mangle]
pub extern "C" fn f0(p0: f64, p1: i64) -> f64 {
    unsafe {
        COUNTER += 1;
        (COUNTER + ((p0 as i64) + (p1 as i64))) as f64
    }
}

#[no_mangle]
pub extern "C" fn f1(p0: i64) -> f64 {
    unsafe {
        COUNTER += 1;
        (COUNTER + ((p0 as i64))) as f64
    }
}
