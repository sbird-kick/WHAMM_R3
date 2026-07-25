(module
(func $r3_main (export "_start") (export "main")
    call $app_0
  call $app_1
  call $app_2
  call $app_3
)
  (func $app_0 (export "app_0")
    i32.const 10 drop)
  (func $app_1 (export "app_1")
    i32.const 20 drop)
  (func $app_2 (export "app_2")
    i32.const 30 drop)
  (func $app_3 (export "app_3")
    i32.const 40 drop)
)