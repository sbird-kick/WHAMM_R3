(module
  (func $r3_main (export "_start") (export "main")
    call $app_level_1)
  (func $r3_h4
    i32.const 103 drop)
  (func $app_level_1 (export "app_level_1")
    call $app_level_2)
  (func $app_level_2 (export "app_level_2")
    call $app_level_3)
  (func $app_level_3 (export "app_level_3")
    call $app_level_4)
  (func $app_level_4 (export "app_level_4")
    call $r3_h4)
)