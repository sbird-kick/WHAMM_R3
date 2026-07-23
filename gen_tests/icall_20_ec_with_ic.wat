;; icall_20_ec_with_ic.wat
;; EC (r3_main->real_fn) combined with IC (real_fn->r3_fn via indirect)
;; Expected: EC, IC, IR
(module
  (memory (export "mem") 1)
  (type $void_void (func))
  (table 1 funcref)
  (elem (i32.const 0) $r3_fn)

  (func $r3_fn)

  (func $real_fn (export "real_fn")
    i32.const 0
    call_indirect (type $void_void))

  (func $r3_main (export "_start")
    call $real_fn)
)
