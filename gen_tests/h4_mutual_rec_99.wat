(module
  (func $r3_main (export "_start") (export "main")
    i32.const 3
    call $app_even drop)
  (func $app_even (export "app_even") (param $n i32) (result i32)
    local.get $n
    i32.const 0
    i32.eq
    if
      i32.const 1
      return
    end
    local.get $n
    i32.const 1
    i32.sub
    call $app_odd
    return)
  (func $app_odd (export "app_odd") (param $n i32) (result i32)
    local.get $n
    i32.const 0
    i32.eq
    if
      i32.const 0
      return
    end
    local.get $n
    i32.const 1
    i32.sub
    call $app_even
    return))
