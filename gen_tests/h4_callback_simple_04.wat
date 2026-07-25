(module
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  (func $r3_helper
    i32.const 123 drop)
  (func $app_work (export "app_work")
    call $r3_helper))
