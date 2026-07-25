(module
  (global $g0 (export "g0") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 555
    call $r3_set_global
    call $app_get_global drop)
  (func $r3_set_global (param $v i32)
    local.get $v
    global.set $g0)
  (func $app_get_global (export "app_get_global") (result i32)
    global.get $g0))
