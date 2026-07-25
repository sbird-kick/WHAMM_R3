;; h7_50_interleave_grow_3p: Host write, grow, host write, read
(module
  (memory (export "memory") 2)
  (func $r3_main (export "_start") (export "main")
    call $r3_write1
    call $app_grow
    call $r3_write2
    call $app_read1
    call $app_read2)
  (func $r3_write1
    i32.const 65536
    i32.const 10
    i32.store)
  (func $app_grow (export "app_grow")
    i32.const 3
    memory.grow
    drop)
  (func $r3_write2
    i32.const 131072
    i32.const 20
    i32.store)
  (func $app_read1 (export "app_read1")
    i32.const 65536
    i32.load
    drop)
  (func $app_read2 (export "app_read2")
    i32.const 131072
    i32.load
    drop))
