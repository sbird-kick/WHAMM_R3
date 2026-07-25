;; s8_44_double_edge_write1
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke1
    call $app_load1)
  (func $r3_poke1
    i32.const 1220 i32.const 12 i32.store8
    i32.const 1223 i32.const 23 i32.store8)
  (func $app_load1 (export "app_load1")
    i32.const 1220 i32.load drop)
)
