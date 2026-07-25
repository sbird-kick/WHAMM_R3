;; call_indirect into host r3 fn (IC/IR) from inside nested if
(module
  (memory (export "memory") 1)
  (table 2 funcref)
  (elem (i32.const 0) $r3_target $app_other)
  (type $v (func))
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_ci)
  (func $r3_poke i32.const 2160 i32.const 7 i32.store)
  (func $r3_target (type $v) nop)
  (func $app_other (type $v) nop)
  (func $app_ci (export "app_ci")
    (block $b
      i32.const 2160 i32.load drop
      (if (i32.const 1)
        (then i32.const 0 call_indirect (type $v))))))
