;; h6_three_fills_48: three consecutive fills
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 100 i32.const 0xAA i32.const 16 memory.fill
    i32.const 200 i32.const 0xBB i32.const 16 memory.fill
    i32.const 300 i32.const 0xCC i32.const 16 memory.fill
    i32.const 100 i32.load drop))
