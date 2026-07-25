;; h7_10_grow_2p_simple: App grows 2 page(s), loads from high addr
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_grow
    call $app_read)
  (func $app_grow (export "app_grow")
    i32.const 2
    memory.grow
    drop)
  (func $app_read (export "app_read")
    i32.const 131068
    i32.load
    drop))
