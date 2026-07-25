(module
  (func $r3_main (export "_start") (export "main")
    i32.const 4
    call $app_f drop)
  (func $app_f (export "app_f") (param $n i32) (result i32)
    local.get $n
    i32.const 0
    i32.le_s
    if
      i32.const 1
      return
    end
    local.get $n
    i32.const 1
    i32.sub
    call $app_g
    i32.const 2
    i32.mul
    return)
  (func $app_g (export "app_g") (param $n i32) (result i32)
    local.get $n
    i32.const 0
    i32.le_s
    if
      i32.const 0
      return
    end
    local.get $n
    i32.const 1
    i32.sub
    call $app_f
    i32.const 3
    i32.add
    return))
