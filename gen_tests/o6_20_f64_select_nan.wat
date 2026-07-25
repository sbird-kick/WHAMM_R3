;; f64 typed select with NaN literal constant operand, feed store
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_fsel)
  (func $r3_poke i32.const 1520 f64.const nan f64.store)
  (func $app_fsel (export "app_fsel")
    i32.const 1528
    i32.const 1520 f64.load
    f64.const 1.5
    i32.const 1
    (select (result f64))
    f64.store
    i32.const 1528 f64.load drop))
