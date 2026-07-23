;; icall_01_basic_to_r3.wat
;; Real code calls r3 function indirectly via call_indirect
;; Expected: EC (r3_main->work), IC (work->r3_helper), IR
(module
  (memory (export "mem") 1)
  (type $void_void (func))
  (table 1 funcref)
  (elem (i32.const 0) $r3_helper)

  (func $r3_helper)

  (func $work (export "work")
    i32.const 0
    call_indirect (type $void_void))

  (func $r3_main (export "_start")
    call $work)
)
