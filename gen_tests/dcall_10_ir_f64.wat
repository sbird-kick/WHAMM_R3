;; IC/IR with f64 return
;; Expected events: IC and IR with f64 result
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    call $r3_ret_f64
    drop)
  (func $r3_ret_f64 (result f64)
    f64.const 1.4142135623))
