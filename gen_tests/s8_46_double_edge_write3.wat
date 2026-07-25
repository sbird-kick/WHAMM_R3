;; s8_46_double_edge_write3
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke3
    call $app_load3)
  (func $r3_poke3
    i32.const 1260 i32.const 14 i32.store8
    i32.const 1263 i32.const 25 i32.store8)
  (func $app_load3 (export "app_load3")
    i32.const 1260 i32.load drop)
)
