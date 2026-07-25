;; select chooses the load ADDRESS between two host-written cells
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_sa drop)
  (func $r3_poke
    i32.const 3840 i32.const 6001 i32.store
    i32.const 3848 i32.const 6002 i32.store)
  (func $app_sa (export "app_sa") (result i32)
    i32.const 3840
    i32.const 3848
    i32.const 0
    select
    i32.load))
