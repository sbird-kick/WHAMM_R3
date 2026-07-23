;; intent: multiple addresses, some with r3 writes
;; expected: EC(work), L at addr 100 and 200
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 100 i32.const 0x11111111 i32.store
    i32.const 200 i32.const 0x22222222 i32.store
    call $work)
  (func $work (export "work")
    i32.const 50 i32.load drop
    i32.const 100 i32.load drop
    i32.const 150 i32.load drop
    i32.const 200 i32.load drop
    i32.const 250 i32.load drop))
