;; h8_36_mg_after_ec: Memory grow detected after external call
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_grower
    i32.const 0 i32.load drop)
  (func $app_grower (export "app_grower")
    i32.const 5 memory.grow drop))
