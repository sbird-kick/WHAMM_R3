;; icall_19_indirect_with_load.wat
;; Call_indirect combined with load (potential L event from r3 write)
;; Expected: EC, L (load from address written by r3), IC
(module
  (memory (export "mem") 1)
  (type $void_void (func))
  (table 1 funcref)
  (elem (i32.const 0) $r3_fn)

  (func $r3_fn)

  (func $work (export "work")
    i32.const 100
    i32.load
    drop
    i32.const 0
    call_indirect (type $void_void))

  (func $r3_main (export "_start")
    i32.const 100
    i32.const 42
    i32.store
    call $work)
)
