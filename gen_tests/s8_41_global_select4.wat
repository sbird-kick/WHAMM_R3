;; s8_41_global_select4
(module
  (memory (export "memory") 1)
  (global $g4 (export "g4") (mut i32) (i32.const 4))
  (func $r3_main (export "_start") (export "main")
    call $r3_poke4
    call $app_read4)
  (func $r3_poke4
    i32.const 45
    global.set $g4)
  (func $app_read4 (export "app_read4")
    (local $x i32) (local $c i32)
    i32.const 0
    local.tee $c
    if (result i32)
      global.get $g4
    else
      global.get $g4
      i32.const 0
      i32.add
    end
    local.set $x
    local.get $x drop)
)
