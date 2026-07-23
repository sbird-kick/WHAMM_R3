;; icall_18_table_diverse.wat
;; Table with diverse mix of real and r3 functions
;; Expected: EC, IC when calling r3, no IC when calling real
(module
  (memory (export "mem") 1)
  (type $void_void (func))
  (table 4 funcref)
  (elem (i32.const 0) $r3_a $real_a $r3_b $real_b)

  (func $r3_a)
  (func $real_a (export "real_a"))
  (func $r3_b)
  (func $real_b (export "real_b"))

  (func $work (export "work")
    i32.const 0
    call_indirect (type $void_void)
    i32.const 1
    call_indirect (type $void_void)
    i32.const 2
    call_indirect (type $void_void)
    i32.const 3
    call_indirect (type $void_void))

  (func $r3_main (export "_start")
    call $work)
)
