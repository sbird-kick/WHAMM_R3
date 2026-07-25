(module
  (func $r3_main (export "_start") (export "main")
    i32.const 5
    call $app_fib drop)
  (func $app_fib (export "app_fib") (param $n i32) (result i32)
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
    call $app_fib
    i32.const 1
    i32.add
    return))
