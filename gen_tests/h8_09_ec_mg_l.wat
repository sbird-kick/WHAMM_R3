;; h8_09_ec_mg_l: External call, then app grows and host loads
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_grow
    i32.const 0 i32.load drop)
  (func $app_grow (export "app_grow")
    i32.const 1 memory.grow drop
    i32.const 0 i32.const 42 i32.store))
