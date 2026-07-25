;; h6_fill_seed_off_31: fill with seed-derived offsets
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 413
    i32.const 107
    i32.const 5
    memory.fill
    i32.const 413 i32.load drop))
