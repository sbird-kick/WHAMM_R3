(module
  (func $r3_main (export "_start") (export "main")
    call $app_level_1)
  (func $r3_h2
    i32.const 101 drop)
  (func $app_level_1 (export "app_level_1")
    call $app_level_2)
  (func $app_level_2 (export "app_level_2")
    call $r3_h2)
)