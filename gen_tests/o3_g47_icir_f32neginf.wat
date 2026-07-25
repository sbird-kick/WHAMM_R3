;; o3_g47_icir_f32neginf
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $work)
  (func $work (export "work")
    call $r3_ret
    drop)
  (func $r3_ret (result f32)
    f32.const -inf))
