(module
  (func $r3_main (export "_start") (export "main")
    i32.const 7
    call $app_deep drop)
  (func $app_deep (export "app_deep") (param $n i32) (result i32)
    local.get $n
    i32.const 0
    i32.le_s
    if
      i32.const 99
      return
    end
    local.get $n
    i32.const 1
    i32.sub
    call $app_deep
    i32.const 1
    i32.add
    return))
