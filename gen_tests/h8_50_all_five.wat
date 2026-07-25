;; h8_50_all_five: EC + IC + L + G + MG all in one test
(module
  (memory (export "memory") 1)
  (global $gq (export "gq") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 16384 i32.const 99 i32.store
    i32.const 123 global.set $gq
    call $app_everything)
  (func $r3_helper
    i32.const 1 drop)
  (func $app_everything (export "app_everything")
    i32.const 16384 i32.load drop
    global.get $gq drop
    i32.const 1 memory.grow drop
    call $r3_helper))
