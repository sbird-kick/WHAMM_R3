(module
  (memory (export "memory") 1)
  (table 4 funcref)
  (type $v (func))
  (elem (i32.const 0) $r3_a $r3_b $r3_a $r3_b)
  (func $r3_main (export "_start") (export "main") call $app_use)
  (func $app_use (export "app_use")
    i32.const 0 ref.func $r3_b table.set
    i32.const 0 call_indirect (type $v))
  (func $r3_a (type $v) nop)
  (func $r3_b (type $v) nop))
