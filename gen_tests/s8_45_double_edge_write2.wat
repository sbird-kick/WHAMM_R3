;; s8_45_double_edge_write2
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke2
    call $app_load2)
  (func $r3_poke2
    i32.const 1240 i32.const 13 i32.store8
    i32.const 1243 i32.const 24 i32.store8)
  (func $app_load2 (export "app_load2")
    i32.const 1240 i32.load drop)
)
