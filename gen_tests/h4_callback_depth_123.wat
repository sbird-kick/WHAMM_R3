(module
  (func $r3_main (export "_start") (export "main")
    call $app_level_1)
  (func $r3_h3
    i32.const 102 drop)
  (func $app_level_1 (export "app_level_1")
    call $app_level_2)
  (func $app_level_2 (export "app_level_2")
    call $app_level_3)
  (func $app_level_3 (export "app_level_3")
    call $r3_h3)
)