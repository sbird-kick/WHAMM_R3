(module
  (memory (export "memory") 1)
  (global $g1 (export "g1") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 777
    call $r3_set_glob
    call $r3_write_mem
    call $app_read_all)
  (func $r3_set_glob (param $v i32)
    local.get $v global.set $g1)
  (func $r3_write_mem
    i32.const 0 i32.const 888 i32.store)
  (func $app_read_all (export "app_read_all")
    global.get $g1 drop
    i32.const 0 i32.load drop))
