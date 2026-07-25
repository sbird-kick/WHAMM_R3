(module
  (func $r3_main (export "_start") (export "main")
    i32.const 8
    call $app_fib drop)
  (func $r3_counter
    i32.const 1 drop)
  (func $app_fib (export "app_fib") (param $n i32) (result i32)
    call $r3_counter
    local.get $n
    i32.const 2
    i32.lt_s
    if
      local.get $n
      return
    end
    local.get $n
    i32.const 1
    i32.sub
    call $app_fib
    local.get $n
    i32.const 2
    i32.sub
    call $app_fib
    i32.add
    return))
