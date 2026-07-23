;; intent: r3 writes multiple bytes, real reads them
;; expected: EC(work), L, L, L, L
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 i32.const 0xAA i32.store8
    i32.const 1 i32.const 0xBB i32.store8
    i32.const 2 i32.const 0xCC i32.store8
    i32.const 3 i32.const 0xDD i32.store8
    call $work)
  (func $work (export "work")
    i32.const 0 i32.load8_u drop
    i32.const 1 i32.load8_u drop
    i32.const 2 i32.load8_u drop
    i32.const 3 i32.load8_u drop))
