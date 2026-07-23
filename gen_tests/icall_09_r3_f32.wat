;; icall_09_r3_f32.wat
;; Call_indirect to r3 function returning f32
;; Expected: EC, IC, IR with f32 return value
(module
  (memory (export "mem") 1)
  (type $void_f32 (func (result f32)))
  (table 1 funcref)
  (elem (i32.const 0) $r3_ret_f32)

  (func $r3_ret_f32 (result f32)
    f32.const 3.14)

  (func $work (export "work")
    i32.const 0
    call_indirect (type $void_f32)
    drop)

  (func $r3_main (export "_start")
    call $work)
)
