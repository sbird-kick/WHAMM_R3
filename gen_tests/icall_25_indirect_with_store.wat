;; icall_25_indirect_with_store.wat
;; Indirect call to function that stores memory, then real code loads
;; Expected: EC, IC, then L event (load divergence)
(module
  (memory (export "mem") 1)
  (type $void_void (func))
  (table 1 funcref)
  (elem (i32.const 0) $r3_store)

  (func $r3_store
    i32.const 200
    i32.const 777
    i32.store)

  (func $work (export "work")
    i32.const 0
    call_indirect (type $void_void)
    i32.const 200
    i32.load
    drop)

  (func $r3_main (export "_start")
    call $work)
)
