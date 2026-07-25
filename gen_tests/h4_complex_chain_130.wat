(module
  (memory (export "memory") 1)
  (global $g (export "g") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    call $app_a)
  (func $r3_mem_op
    i32.const 0 i32.const 555 i32.store)
  (func $app_a (export "app_a")
    call $app_b)
  (func $app_b (export "app_b")
    call $r3_mem_op
    call $app_c)
  (func $app_c (export "app_c")
    i32.const 0 i32.load drop))
