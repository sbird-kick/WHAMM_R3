;; h7_03_grow_3p_simple: App grows 3 page(s), loads from high addr
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_grow
    call $app_read)
  (func $app_grow (export "app_grow")
    i32.const 3
    memory.grow
    drop)
  (func $app_read (export "app_read")
    i32.const 196604
    i32.load
    drop))
