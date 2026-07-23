;; icall_06_r3_void.wat
;; Call_indirect to r3 function returning void
;; Expected: EC (r3_main->work), IC (work->r3_void), IR
(module
  (memory (export "mem") 1)
  (type $void_void (func))
  (table 1 funcref)
  (elem (i32.const 0) $r3_void)

  (func $r3_void)

  (func $work (export "work")
    i32.const 0
    call_indirect (type $void_void))

  (func $r3_main (export "_start")
    call $work)
)
