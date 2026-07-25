;; h6_fill_seed_off_45: fill with seed-derived offsets
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 156
    i32.const 138
    i32.const 22
    memory.fill
    i32.const 156 i32.load drop))
