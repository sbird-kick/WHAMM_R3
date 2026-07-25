;; local.tee produces the ADDRESS used by a subsequent load
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_ta drop)
  (func $r3_poke i32.const 3280 i32.const 8181 i32.store)
  (func $app_ta (export "app_ta") (result i32)
    (local $p i32)
    i32.const 3280 local.tee $p
    drop
    local.get $p i32.load))
