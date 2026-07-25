;; h8_43_global_chain: Chain of globals
(module
  (memory (export "memory") 1)
  (global $gl (export "gl") (mut i32) (i32.const 0))
  (global $gm (export "gm") (mut i32) (i32.const 0))
  (global $gn (export "gn") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 11 global.set $gl
    i32.const 22 global.set $gm
    i32.const 33 global.set $gn
    call $app_readall)
  (func $app_readall (export "app_readall")
    global.get $gl drop
    global.get $gm drop
    global.get $gn drop))
