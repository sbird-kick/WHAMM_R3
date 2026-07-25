static mut COUNTER: i64 = 84;

#[no_mangle]
pub extern "C" fn f0(p0: i64, p1: i64) -> i64 {
    unsafe {
        COUNTER += 1;
        (COUNTER + ((p0 as i64) + (p1 as i64))) as i64
    }
}

#[no_mangle]
pub extern "C" fn f1(p0: f64) -> i64 {
    unsafe {
        COUNTER += 1;
        (COUNTER + ((p0 as i64))) as i64
    }
}

#[no_mangle]
pub extern "C" fn f2(p0: f64) -> f64 {
    unsafe {
        COUNTER += 1;
        (COUNTER + ((p0 as i64))) as f64
    }
}

#[no_mangle]
pub extern "C" fn f3(p0: f64) -> i32 {
    unsafe {
        COUNTER += 1;
        (COUNTER + ((p0 as i64))) as i32
    }
}
