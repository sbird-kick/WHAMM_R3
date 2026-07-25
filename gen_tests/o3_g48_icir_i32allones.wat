;; o3_g48_icir_i32allones
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $work)
  (func $work (export "work")
    call $r3_ret
    drop)
  (func $r3_ret (result i32)
    i32.const 0xffffffff))
