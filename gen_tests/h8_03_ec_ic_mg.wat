;; h8_03_ec_ic_mg: EC + IC + MG (memory grow)
;; r3_main calls app_grow (EC), app_grow calls r3_helper (IC), grows memory (MG)
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_grow)
  (func $r3_helper
    i32.const 1 drop)
  (func $app_grow (export "app_grow")
    i32.const 2 memory.grow drop
    call $r3_helper))
