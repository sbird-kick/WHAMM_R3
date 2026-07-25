;; h6_ec_fill_23: EC with fill
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_fill)
  (func $app_fill (export "fill")
    i32.const 100 i32.const 0xCC i32.const 50 memory.fill))
