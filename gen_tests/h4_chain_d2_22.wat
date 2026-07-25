(module
(func $r3_main (export "_start") (export "main")
    call $app_0)
  (func $app_0 (export "app_0")
    call $app_1)
  (func $app_1 (export "app_1")
    i32.const 4411 drop)
)