;; select operands are two host-written globals -> two G, feed store
(module
  (memory (export "memory") 1)
  (global $ga (export "ga") (mut i32) (i32.const 0))
  (global $gb (export "gb") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 12 global.set $ga
    i32.const 34 global.set $gb
    call $app_sog)
  (func $app_sog (export "app_sog")
    i32.const 1280
    global.get $ga
    global.get $gb
    i32.const 1
    select
    i32.store
    i32.const 1280 i32.load drop))
