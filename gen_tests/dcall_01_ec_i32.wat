;; EC parameter recording with i32
;; Expected events: EC with arg0=42
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 42
    call $take_i32)
  (func $take_i32 (export "take_i32") (param i32)
    ;; parameter consumed
    ))
