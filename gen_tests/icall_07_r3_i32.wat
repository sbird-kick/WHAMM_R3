;; icall_07_r3_i32.wat
;; Call_indirect to r3 function returning i32
;; Expected: EC, IC, IR with i32 return value
(module
  (memory (export "mem") 1)
  (type $void_i32 (func (result i32)))
  (table 1 funcref)
  (elem (i32.const 0) $r3_ret_i32)

  (func $r3_ret_i32 (result i32)
    i32.const 42)

  (func $work (export "work")
    i32.const 0
    call_indirect (type $void_i32)
    drop)

  (func $r3_main (export "_start")
    call $work)
)
