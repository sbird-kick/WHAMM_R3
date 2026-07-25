;; h6_fill_seed_off_43: fill with seed-derived offsets
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 309
    i32.const 173
    i32.const 12
    memory.fill
    i32.const 309 i32.load drop))
