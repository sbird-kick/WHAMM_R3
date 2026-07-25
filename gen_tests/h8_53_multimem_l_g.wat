;; h8_53_multimem_l_g: Two memories and globals
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (global $gr (export "gr") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 100 i32.const 111 i32.store $m0
    i32.const 100 i32.const 222 i32.store $m1
    i32.const 333 global.set $gr
    call $app_check)
  (func $app_check (export "app_check")
    i32.const 100 i32.load $m0 drop
    i32.const 100 i32.load $m1 drop
    global.get $gr drop))
