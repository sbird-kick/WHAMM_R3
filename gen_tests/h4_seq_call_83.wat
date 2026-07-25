(module
(func $r3_main (export "_start") (export "main")
    call $app_0
    call $app_1
    call $app_2)
  (func $app_0 (export "app_0")
    i32.const 100 drop)
  (func $app_1 (export "app_1")
    i32.const 101 drop)
  (func $app_2 (export "app_2")
    i32.const 102 drop)
)