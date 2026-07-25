;; h8_21_nested_ec_ic: Nested EC then IC calls
(module
  (memory (export "memory") 1)
  (global $ge (export "ge") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 123 global.set $ge
    call $app_level1)
  (func $r3_helper
    i32.const 0 drop)
  (func $app_level1 (export "app_level1")
    call $app_level2)
  (func $app_level2 (export "app_level2")
    global.get $ge drop
    call $r3_helper))
