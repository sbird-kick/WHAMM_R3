;; h8_44_mixed_stores: Mix of store sizes
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0 i32.const 1 i32.store8
    i32.const 4 i32.const 257 i32.store16
    i32.const 8 i32.const 100000 i32.store
    call $app_readmixed)
  (func $app_readmixed (export "app_readmixed")
    i32.const 0 i32.load8_u drop
    i32.const 4 i32.load16_u drop
    i32.const 8 i32.load drop))
