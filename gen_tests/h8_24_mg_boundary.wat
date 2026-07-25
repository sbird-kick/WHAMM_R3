;; h8_24_mg_boundary: MG observed at boundary
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_grow_then_check)
  (func $r3_check
    i32.const 0 i32.load drop)
  (func $app_grow_then_check (export "app_grow_then_check")
    i32.const 1 memory.grow drop
    call $r3_check))
