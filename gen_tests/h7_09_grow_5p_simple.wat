;; h7_09_grow_5p_simple: App grows 5 page(s), loads from high addr
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_grow
    call $app_read)
  (func $app_grow (export "app_grow")
    i32.const 5
    memory.grow
    drop)
  (func $app_read (export "app_read")
    i32.const 327676
    i32.load
    drop))
