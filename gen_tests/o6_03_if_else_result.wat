;; if/else both arms load, produce result value
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    i32.const 1 call $app_pick drop
    i32.const 0 call $app_pick drop)
  (func $r3_poke
    i32.const 240 i32.const 111 i32.store
    i32.const 248 i32.const 222 i32.store)
  (func $app_pick (export "app_pick") (param $c i32) (result i32)
    (if (result i32) (local.get $c)
      (then i32.const 240 i32.load)
      (else i32.const 248 i32.load))))
