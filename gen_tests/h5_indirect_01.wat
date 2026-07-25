;; h5_indirect_01: Simple indirect call to r3 function (void type)
;; IC event: app calls r3 via indirect
(module
  (memory (export "memory") 1)
  (type $void_void (func))
  (table 2 funcref)
  (elem (i32.const 0) $r3_host)
  
  (func $r3_main (export "_start") (export "main")
    call $app_caller)
  
  (func $r3_host
    ;; r3 function - not instrumented
  )
  
  (func $app_caller (export "app_caller")
    i32.const 0 call_indirect (type $void_void)))
