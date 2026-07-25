;; untyped select of two host i64 globals (two G), result dropped
(module
  (memory (export "memory") 1)
  (global $x (export "x") (mut i64) (i64.const 0))
  (global $y (export "y") (mut i64) (i64.const 0))
  (func $r3_main (export "_start") (export "main")
    i64.const 64064 global.set $x
    i64.const 46046 global.set $y
    call $app_sug drop)
  (func $app_sug (export "app_sug") (result i64)
    global.get $x
    global.get $y
    i32.const 1
    select))
