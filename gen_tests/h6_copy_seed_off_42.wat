;; h6_copy_seed_off_42: copy with seed-derived offsets
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 290 i32.const 0x77 i32.store
    i32.const 75
    i32.const 290
    i32.const 10
    memory.copy
    i32.const 75 i32.load drop))
