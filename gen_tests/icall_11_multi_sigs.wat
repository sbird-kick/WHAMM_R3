;; icall_11_multi_sigs.wat
;; Table with multiple type signatures (void->void, i32->void, void->i32)
;; Expected: EC, multiple IC events with different signatures
(module
  (memory (export "mem") 1)
  (type $void_void (func))
  (type $i32_void (func (param i32)))
  (type $void_i32 (func (result i32)))
  (table 3 funcref)
  (elem (i32.const 0) $r3_a $r3_b $r3_c)

  (func $r3_a)
  (func $r3_b (param i32))
  (func $r3_c (result i32) i32.const 99)

  (func $work (export "work")
    i32.const 0
    call_indirect (type $void_void)
    i32.const 42
    i32.const 1
    call_indirect (type $i32_void)
    i32.const 2
    call_indirect (type $void_i32)
    drop)

  (func $r3_main (export "_start")
    call $work)
)
