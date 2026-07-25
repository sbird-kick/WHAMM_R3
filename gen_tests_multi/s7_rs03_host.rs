static mut COUNTER: i64 = 88;

#[no_mangle]
pub extern "C" fn f0(p0: i32) -> f32 {
    unsafe {
        COUNTER += 1;
        (COUNTER + ((p0 as i64))) as f32
    }
}

#[no_mangle]
pub extern "C" fn f1(p0: f32) -> i32 {
    unsafe {
        COUNTER += 1;
        (COUNTER + ((p0 as i64))) as i32
    }
}

#[no_mangle]
pub extern "C" fn f2(p0: f64) -> i32 {
    unsafe {
        COUNTER += 1;
        (COUNTER + ((p0 as i64))) as i32
    }
}

#[no_mangle]
pub extern "C" fn f3(p0: i32, p1: i32) -> f32 {
    unsafe {
        COUNTER += 1;
        (COUNTER + ((p0 as i64) + (p1 as i64))) as f32
    }
}
