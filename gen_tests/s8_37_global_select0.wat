;; s8_37_global_select0
(module
  (memory (export "memory") 1)
  (global $g0 (export "g0") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    call $r3_poke0
    call $app_read0)
  (func $r3_poke0
    i32.const 41
    global.set $g0)
  (func $app_read0 (export "app_read0")
    (local $x i32) (local $c i32)
    i32.const 0
    local.tee $c
    if (result i32)
      global.get $g0
    else
      global.get $g0
      i32.const 0
      i32.add
    end
    local.set $x
    local.get $x drop)
)
