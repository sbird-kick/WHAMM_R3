;; h8_37_nested_ic: Nested internal calls
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_outer)
  (func $r3_h1 i32.const 0 drop)
  (func $r3_h2
    call $r3_h1)
  (func $app_outer (export "app_outer")
    call $r3_h2))
