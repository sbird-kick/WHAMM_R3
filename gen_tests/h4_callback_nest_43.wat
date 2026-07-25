(module
  (func $r3_main (export "_start") (export "main")
    call $app_0)
  (func $r3_helper
    i32.const 204 drop)
  (func $app_0 (export "app_0")
    call $r3_helper))
