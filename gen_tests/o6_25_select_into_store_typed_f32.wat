;; f32 typed select of loaded vs const, stored then loaded back
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_f32)
  (func $r3_poke i32.const 2240 f32.const 3.5 f32.store)
  (func $app_f32 (export "app_f32")
    i32.const 2248
    i32.const 2240 f32.load
    f32.const 1.25
    i32.const 0
    (select (result f32))
    f32.store
    i32.const 2248 f32.load drop))
