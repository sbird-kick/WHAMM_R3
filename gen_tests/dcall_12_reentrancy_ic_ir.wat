;; Reentrancy: IC/IR when real code calls r3 function
;; Expected events: EC for $work, IC/IR for $r3_func
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    call $r3_func
    drop)
  (func $r3_func (result i32)
    i32.const 5))
