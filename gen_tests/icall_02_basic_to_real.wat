;; icall_02_basic_to_real.wat
;; Real code calls another real function indirectly via call_indirect
;; Expected: EC (r3_main->work), no IC (work->helper is not a boundary)
(module
  (memory (export "mem") 1)
  (type $void_void (func))
  (table 1 funcref)
  (elem (i32.const 0) $helper)

  (func $helper (export "helper"))

  (func $work (export "work")
    i32.const 0
    call_indirect (type $void_void))

  (func $r3_main (export "_start")
    call $work)
)
