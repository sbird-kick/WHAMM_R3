;; select condition is a host-written global (G), operands loaded
(module
  (memory (export "memory") 1)
  (global $c (export "c") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_scg drop)
  (func $r3_poke
    i32.const 800 i32.const 1000 i32.store
    i32.const 808 i32.const 2000 i32.store
    i32.const 1 global.set $c)
  (func $app_scg (export "app_scg") (result i32)
    i32.const 800 i32.load
    i32.const 808 i32.load
    global.get $c
    select))
