(module
  (func $r3_main (export "_start") (export "main")
    call $app_outer)
  (func $r3_helper
    i32.const 123 drop)
  (func $app_outer (export "app_outer")
    call $r3_helper
    call $app_inner)
  (func $app_inner (export "app_inner")
    i32.const 456 drop))
