(module
  (global $g (export "g") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 7
    call $app_rec drop)
  (func $app_rec (export "app_rec") (param $n i32) (result i32)
    local.get $n
    i32.const 0
    i32.le_s
    if
      i32.const 1
      return
    end
    local.get $n
    global.set $g
    local.get $n
    i32.const 1
    i32.sub
    call $app_rec
    i32.const 1
    i32.add
    return))
