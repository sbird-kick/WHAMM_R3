;; h8_33_global_initial: Global with initial value then modify
(module
  (memory (export "memory") 1)
  (global $gi (export "gi") (mut i32) (i32.const 100))
  (func $r3_main (export "_start") (export "main")
    i32.const 456 global.set $gi
    call $app_check)
  (func $app_check (export "app_check")
    global.get $gi drop))
