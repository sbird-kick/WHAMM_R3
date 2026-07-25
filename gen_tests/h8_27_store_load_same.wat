;; h8_27_store_load_same: Host stores, app loads same location
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 256 i32.const 42 i32.store
    call $app_load)
  (func $app_load (export "app_load")
    i32.const 256 i32.load drop))
