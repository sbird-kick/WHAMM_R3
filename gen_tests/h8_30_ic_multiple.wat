;; h8_30_ic_multiple: Multiple IC calls
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_caller)
  (func $r3_helper1 i32.const 0 drop)
  (func $r3_helper2 i32.const 1 drop)
  (func $app_caller (export "app_caller")
    call $r3_helper1
    call $r3_helper2))
