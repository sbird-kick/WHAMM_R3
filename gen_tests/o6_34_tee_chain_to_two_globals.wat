;; read host global (G) then tee-chain into two app globals
(module
  (memory (export "memory") 1)
  (global $src (export "src") (mut i64) (i64.const 0))
  (global $a (mut i64) (i64.const 0))
  (global $b (mut i64) (i64.const 0))
  (func $r3_main (export "_start") (export "main")
    i64.const 7777 global.set $src
    call $app_tc)
  (func $app_tc (export "app_tc")
    (local $t i64)
    global.get $src
    local.tee $t
    global.set $a
    local.get $t
    global.set $b))
