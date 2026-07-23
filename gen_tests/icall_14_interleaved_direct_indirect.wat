;; icall_14_interleaved_direct_indirect.wat
;; Mix of direct and indirect calls to same r3 function
;; Expected: EC, IR for direct, IC/IR for indirect
(module
  (memory (export "mem") 1)
  (type $void_void (func))
  (table 1 funcref)
  (elem (i32.const 0) $r3_helper)

  (func $r3_helper)

  (func $work (export "work")
    call $r3_helper
    i32.const 0
    call_indirect (type $void_void)
    call $r3_helper
    i32.const 0
    call_indirect (type $void_void))

  (func $r3_main (export "_start")
    call $work)
)
