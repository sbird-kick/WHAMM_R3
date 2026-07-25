;; Global read in a loop structure
(module
  (global $g (export "g") (mut i32) (i32.const 0))
  (global $i (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 3301
    global.set $g
    call $app_loop)
  (func $app_loop (export "app_loop")
    i32.const 0
    global.set $i
    loop $L
      global.get $g drop
      global.get $i
      i32.const 1
      i32.add
      global.set $i
      global.get $i
      i32.const 3
      i32.lt_u
      br_if $L
    end))
