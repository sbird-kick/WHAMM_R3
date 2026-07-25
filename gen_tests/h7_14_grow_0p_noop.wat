;; h7_14_grow_0p_noop: App grows 0 pages (no-op)
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $app_grow_zero
    call $app_size_check)
  (func $app_grow_zero (export "app_grow_zero")
    i32.const 0
    memory.grow
    drop)
  (func $app_size_check (export "app_size_check")
    memory.size
    i32.const 1
    i32.ne
    if
      unreachable
    end))
