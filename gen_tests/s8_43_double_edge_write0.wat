;; s8_43_double_edge_write0
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke0
    call $app_load0)
  (func $r3_poke0
    i32.const 1200 i32.const 11 i32.store8
    i32.const 1203 i32.const 22 i32.store8)
  (func $app_load0 (export "app_load0")
    i32.const 1200 i32.load drop)
)
