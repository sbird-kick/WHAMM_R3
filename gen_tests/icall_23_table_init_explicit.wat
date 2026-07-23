;; icall_23_table_init_explicit.wat
;; Explicit elem segment with alternating r3 and real functions
;; Expected: EC, mixed IC/non-IC events
(module
  (memory (export "mem") 1)
  (type $void_void (func))
  (table 5 funcref)
  (elem (i32.const 0) $r3_x $real_y $r3_z $real_w $r3_v)

  (func $r3_x)
  (func $real_y (export "real_y"))
  (func $r3_z)
  (func $real_w (export "real_w"))
  (func $r3_v)

  (func $work (export "work")
    i32.const 0
    call_indirect (type $void_void)
    i32.const 1
    call_indirect (type $void_void)
    i32.const 2
    call_indirect (type $void_void)
    i32.const 3
    call_indirect (type $void_void)
    i32.const 4
    call_indirect (type $void_void))

  (func $r3_main (export "_start")
    call $work)
)
