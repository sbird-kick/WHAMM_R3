;; icall_08_r3_i64.wat
;; Call_indirect to r3 function returning i64
;; Expected: EC, IC, IR with i64 return value
(module
  (memory (export "mem") 1)
  (type $void_i64 (func (result i64)))
  (table 1 funcref)
  (elem (i32.const 0) $r3_ret_i64)

  (func $r3_ret_i64 (result i64)
    i64.const 100)

  (func $work (export "work")
    i32.const 0
    call_indirect (type $void_i64)
    drop)

  (func $r3_main (export "_start")
    call $work)
)
