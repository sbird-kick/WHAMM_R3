(module
  (func $r3_main (export "_start") (export "main")
    call $app_start)
  (func $r3_work
    i32.const 99 drop)
  (func $app_start (export "app_start")
    call $app_middle)
  (func $app_middle (export "app_middle")
    call $r3_work)
  (func $app_end (export "app_end")
    i32.const 77 drop))
