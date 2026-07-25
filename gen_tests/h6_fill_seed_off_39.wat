;; h6_fill_seed_off_39: fill with seed-derived offsets
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 199
    i32.const 21
    i32.const 9
    memory.fill
    i32.const 199 i32.load drop))
