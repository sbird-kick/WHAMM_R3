;; h7_01_grow_4p_simple: App grows 4 page(s), loads from high addr
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_grow
    call $app_read)
  (func $app_grow (export "app_grow")
    i32.const 4
    memory.grow
    drop)
  (func $app_read (export "app_read")
    i32.const 262140
    i32.load
    drop))
