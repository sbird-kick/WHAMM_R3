;; Two r3 functions with identical signatures (distinct IC fids)
;; Expected events: IC/IR for both $r3_func1 and $r3_func2 with distinct fids
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    call $r3_func1
    drop
    call $r3_func2
    drop)
  (func $r3_func1 (result i32)
    i32.const 11)
  (func $r3_func2 (result i32)
    i32.const 22))
