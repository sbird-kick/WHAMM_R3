(module
  (func $r3_main (export "_start") (export "main")
    call $app_a)
  (func $app_a (export "app_a")
    call $app_b)
  (func $app_b (export "app_b")
    call $app_c)
  (func $app_c (export "app_c")
    i32.const 1 drop))
