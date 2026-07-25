;; s8_40_global_select3
(module
  (memory (export "memory") 1)
  (global $g3 (export "g3") (mut i32) (i32.const 3))
  (func $r3_main (export "_start") (export "main")
    call $r3_poke3
    call $app_read3)
  (func $r3_poke3
    i32.const 44
    global.set $g3)
  (func $app_read3 (export "app_read3")
    (local $x i32) (local $c i32)
    i32.const 1
    local.tee $c
    if (result i32)
      global.get $g3
    else
      global.get $g3
      i32.const 0
      i32.add
    end
    local.set $x
    local.get $x drop)
)
