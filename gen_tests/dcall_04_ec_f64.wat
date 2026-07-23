;; EC parameter recording with f64
;; Expected events: EC with bitpattern for 2.718281828
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    f64.const 2.718281828
    call $take_f64)
  (func $take_f64 (export "take_f64") (param f64)
    ))
