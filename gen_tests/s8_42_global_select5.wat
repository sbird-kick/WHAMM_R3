;; s8_42_global_select5
(module
  (memory (export "memory") 1)
  (global $g5 (export "g5") (mut i32) (i32.const 5))
  (func $r3_main (export "_start") (export "main")
    call $r3_poke5
    call $app_read5)
  (func $r3_poke5
    i32.const 46
    global.set $g5)
  (func $app_read5 (export "app_read5")
    (local $x i32) (local $c i32)
    i32.const 1
    local.tee $c
    if (result i32)
      global.get $g5
    else
      global.get $g5
      i32.const 0
      i32.add
    end
    local.set $x
    local.get $x drop)
)
