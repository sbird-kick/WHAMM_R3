;; icall_12_dup_indices.wat
;; Same r3 function at multiple table indices
;; Expected: EC, IC events via different indices calling same function
(module
  (memory (export "mem") 1)
  (type $void_void (func))
  (table 3 funcref)
  (elem (i32.const 0) $r3_helper $r3_helper $r3_helper)

  (func $r3_helper)

  (func $work (export "work")
    i32.const 0
    call_indirect (type $void_void)
    i32.const 1
    call_indirect (type $void_void)
    i32.const 2
    call_indirect (type $void_void))

  (func $r3_main (export "_start")
    call $work)
)
