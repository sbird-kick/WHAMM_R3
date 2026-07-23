;; icall_17_nested_indirect.wat
;; Real code calls indirect which calls indirect to r3 function
;; Expected: EC, IC for real->real indirect, IC for real->r3 indirect
(module
  (memory (export "mem") 1)
  (type $void_void (func))
  (table 2 funcref)
  (elem (i32.const 0) $middle $r3_fn)

  (func $r3_fn)

  (func $middle (export "middle")
    i32.const 1
    call_indirect (type $void_void))

  (func $work (export "work")
    i32.const 0
    call_indirect (type $void_void))

  (func $r3_main (export "_start")
    call $work)
)
