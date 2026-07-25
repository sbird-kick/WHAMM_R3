(module
  (func $r3_main (export "_start") (export "main")
    call $app_a
    call $app_b
    call $app_c)
  (func $app_a (export "app_a")
    i32.const 10 drop)
  (func $app_b (export "app_b")
    i32.const 20 drop)
  (func $app_c (export "app_c")
    i32.const 30 drop))
