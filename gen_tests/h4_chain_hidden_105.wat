(module
  (func $r3_main (export "_start") (export "main")
    call $app_a)
  (func $app_a (export "app_a")
    call $app_hidden)
  (func $app_hidden
    call $app_b)
  (func $app_b (export "app_b")
    i32.const 42 drop))
