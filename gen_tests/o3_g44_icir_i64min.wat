;; o3_g44_icir_i64min
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $work)
  (func $work (export "work")
    call $r3_ret
    drop)
  (func $r3_ret (result i64)
    i64.const 0x8000000000000000))
