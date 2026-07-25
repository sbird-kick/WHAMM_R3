(module
  (func $r3_main (export "_start") (export "main")
    call $app_a
    call $app_b)
  (func $r3_helper_1
    i32.const 11 drop)
  (func $r3_helper_2
    i32.const 22 drop)
  (func $app_a (export "app_a")
    call $r3_helper_1)
  (func $app_b (export "app_b")
    call $r3_helper_2))
