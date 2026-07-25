;; h8_10_ic_l_mg: App calls host, loads memory, grows
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 112 i32.const 33 i32.store
    call $app_work)
  (func $r3_helper
    i32.const 0 drop)
  (func $app_work (export "app_work")
    i32.const 112 i32.load drop
    call $r3_helper
    i32.const 2 memory.grow drop))
