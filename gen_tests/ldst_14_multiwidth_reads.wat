;; intent: read 4 bytes at different widths after r3 write
;; expected: EC(work), L, L, L, L
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0 i32.const 0x01020304 i32.store
    call $work)
  (func $work (export "work")
    i32.const 0 i32.load8_u drop
    i32.const 1 i32.load8_u drop
    i32.const 2 i32.load8_u drop
    i32.const 3 i32.load8_u drop))
