;; icall_13_table_set_by_r3.wat
;; r3-code executes table.set to retarget slot, then real code calls_indirect
;; Expected: EC, then IC must show ACTUAL runtime callee (r3_b, not r3_a)
(module
  (memory (export "mem") 1)
  (type $void_void (func))
  (table 2 funcref)
  (elem (i32.const 0) $r3_a $r3_b)

  (func $r3_a)
  (func $r3_b)

  (func $work (export "work")
    i32.const 0
    call_indirect (type $void_void))

  (func $r3_main (export "_start")
    i32.const 0
    ref.func $r3_b
    table.set 0
    call $work)
)
