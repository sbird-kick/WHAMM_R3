;; untyped select of two loaded values, store result, load back
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_sel)
  (func $r3_poke
    i32.const 640 i32.const 500 i32.store
    i32.const 648 i32.const 600 i32.store)
  (func $app_sel (export "app_sel")
    i32.const 656
    i32.const 640 i32.load
    i32.const 648 i32.load
    i32.const 1
    select
    i32.store
    i32.const 656 i32.load drop))
