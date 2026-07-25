;; o3_b07_store8s_trunc
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 16976 i64.const 0x00000000000000ff i64.store8
    call $rd)
  (func $rd (export "rd")
    i32.const 16976 i64.load8_s drop))
