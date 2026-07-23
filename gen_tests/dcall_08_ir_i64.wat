;; IC/IR with i64 return
;; Expected events: IC and IR with i64 result
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    call $r3_ret_i64
    drop)
  (func $r3_ret_i64 (result i64)
    i64.const 88888888))
