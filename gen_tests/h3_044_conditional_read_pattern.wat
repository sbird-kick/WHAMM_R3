;; Simulate conditional reads (app reads different globals in sequence)
(module
  (global $g1 (export "g1") (mut i32) (i32.const 0))
  (global $g2 (export "g2") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 1
    global.set $g1
    i32.const 2
    global.set $g2
    call $app_cond)
  (func $app_cond (export "app_cond")
    global.get $g1
    if
      global.get $g2 drop
    else
      global.get $g1 drop
    end))
