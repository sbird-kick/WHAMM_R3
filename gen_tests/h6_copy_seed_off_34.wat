;; h6_copy_seed_off_34: copy with seed-derived offsets
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 100 i32.const 0x77 i32.store
    i32.const 46
    i32.const 100
    i32.const 9
    memory.copy
    i32.const 46 i32.load drop))
