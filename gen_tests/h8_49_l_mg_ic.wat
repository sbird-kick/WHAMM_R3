;; h8_49_l_mg_ic: Load, grow, internal call
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 8192 i32.const 444 i32.store
    call $app_sequence)
  (func $r3_helper i32.const 0 drop)
  (func $app_sequence (export "app_sequence")
    i32.const 8192 i32.load drop
    i32.const 2 memory.grow drop
    call $r3_helper))
