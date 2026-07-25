;; h8_34_sequential_calls: Sequential external calls
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_first
    call $app_second)
  (func $app_first (export "app_first")
    i32.const 0 drop)
  (func $app_second (export "app_second")
    i32.const 1 drop))
