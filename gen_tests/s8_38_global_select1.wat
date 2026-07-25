;; s8_38_global_select1
(module
  (memory (export "memory") 1)
  (global $g1 (export "g1") (mut i32) (i32.const 1))
  (func $r3_main (export "_start") (export "main")
    call $r3_poke1
    call $app_read1)
  (func $r3_poke1
    i32.const 42
    global.set $g1)
  (func $app_read1 (export "app_read1")
    (local $x i32) (local $c i32)
    i32.const 1
    local.tee $c
    if (result i32)
      global.get $g1
    else
      global.get $g1
      i32.const 0
      i32.add
    end
    local.set $x
    local.get $x drop)
)
