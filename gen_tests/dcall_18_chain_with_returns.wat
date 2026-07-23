;; Chain with return values: real→r3→real with value passing
;; Expected events: EC for $real1, IC/IR for $r3_func with return values
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $real1
    drop)
  (func $real1 (export "real1") (result i32)
    call $r3_func
    i32.const 1
    i32.add)
  (func $r3_func (result i32)
    i32.const 99))
