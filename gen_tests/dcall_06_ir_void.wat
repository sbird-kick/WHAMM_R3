;; IC/IR with void return (no results)
;; Expected events: IC (into $r3_func) and IR (from $r3_func)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    call $r3_void_func)
  (func $r3_void_func
    ;; r3 function with void return
    nop))
