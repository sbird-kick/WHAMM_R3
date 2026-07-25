(module
  (func $r3_main (export "_start") (export "main")
    call $app_start)
  (func $r3_mid
    i32.const 77 drop)
  (func $app_start (export "app_start")
    call $app_a)
  (func $app_a (export "app_a")
    call $r3_mid)
  (func $app_b (export "app_b")
    i32.const 88 drop))
