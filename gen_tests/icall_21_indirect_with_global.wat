;; icall_21_indirect_with_global.wat
;; Indirect call with global read before/after (potential G event)
;; Expected: EC, G (global divergence if r3 writes), IC
(module
  (memory (export "mem") 1)
  (global $counter (export "counter") (mut i32) (i32.const 0))
  (type $void_void (func))
  (table 1 funcref)
  (elem (i32.const 0) $r3_fn)

  (func $r3_fn)

  (func $work (export "work")
    global.get $counter
    drop
    i32.const 0
    call_indirect (type $void_void))

  (func $r3_main (export "_start")
    i32.const 99
    global.set $counter
    call $work)
)
