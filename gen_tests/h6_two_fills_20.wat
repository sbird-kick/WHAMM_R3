;; h6_two_fills_20: two consecutive fills
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $app_work (export "work")
    i32.const 100 i32.const 0x11 i32.const 32 memory.fill
    i32.const 200 i32.const 0x22 i32.const 32 memory.fill
    i32.const 100 i32.load drop
    i32.const 200 i32.load drop))
