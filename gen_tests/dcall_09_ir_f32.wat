;; IC/IR with f32 return
;; Expected events: IC and IR with f32 result
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    call $r3_ret_f32
    drop)
  (func $r3_ret_f32 (result f32)
    f32.const 1.61803))
