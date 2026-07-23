;; r3 fn writes memory AND returns value (IR + later L)
;; Expected events: EC for $work, IC/IR for $r3_writer, L when real code reads modified memory
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    call $r3_writer
    drop
    ;; read the memory location modified by r3_writer
    i32.const 0
    i32.load
    drop)
  (func $r3_writer (result i32)
    ;; r3 code writes memory (invisible to shadow initially)
    i32.const 0
    i32.const 0xdeadbeef
    i32.store
    ;; return a value to signal completion
    i32.const 42))
