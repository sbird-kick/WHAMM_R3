;; h7_33_multi_grow_3_1_2: Sequential grows
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_grow1
    call $app_grow2
    call $app_grow3
    call $app_read)
  (func $app_grow1 (export "app_grow1")
    i32.const 3
    memory.grow
    drop)
  (func $app_grow2 (export "app_grow2")
    i32.const 1
    memory.grow
    drop)
  (func $app_grow3 (export "app_grow3")
    i32.const 2
    memory.grow
    drop)
  (func $app_read (export "app_read")
    i32.const 393212
    i32.load
    drop))
