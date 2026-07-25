;; app calls host r3 fn inside nested if -> IC/IR, plus load
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_call)
  (func $r3_poke i32.const 1040 i32.const 77 i32.store)
  (func $r3_helper
    nop)
  (func $app_call (export "app_call")
    (if (i32.const 1)
      (then
        (block $b
          i32.const 1040 i32.load drop
          call $r3_helper)))))
