;; EC parameter recording with i64
;; Expected events: EC with arg0=9999999999
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i64.const 9999999999
    call $take_i64)
  (func $take_i64 (export "take_i64") (param i64)
    ))
