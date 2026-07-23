;; IC/IR with i32 return
;; Expected events: IC and IR with i32 result
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    call $r3_ret_i32
    drop)
  (func $r3_ret_i32 (result i32)
    i32.const 77))
