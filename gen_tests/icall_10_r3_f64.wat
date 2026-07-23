;; icall_10_r3_f64.wat
;; Call_indirect to r3 function returning f64
;; Expected: EC, IC, IR with f64 return value
(module
  (memory (export "mem") 1)
  (type $void_f64 (func (result f64)))
  (table 1 funcref)
  (elem (i32.const 0) $r3_ret_f64)

  (func $r3_ret_f64 (result f64)
    f64.const 2.718)

  (func $work (export "work")
    i32.const 0
    call_indirect (type $void_f64)
    drop)

  (func $r3_main (export "_start")
    call $work)
)
