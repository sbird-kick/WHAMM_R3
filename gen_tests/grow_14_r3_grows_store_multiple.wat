;; Intent: r3_main grows, stores multiple values, real loads multiple
;; Expected events: EC, MG, multiple L (one per unique stored location loaded)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 1
    memory.grow
    drop
    i32.const 65536
    i32.const 11
    i32.store
    i32.const 65540
    i32.const 22
    i32.store
    i32.const 65544
    i32.const 33
    i32.store
    call $work)
  (func $work (export "work")
    i32.const 65536
    i32.load
    drop
    i32.const 65540
    i32.load
    drop
    i32.const 65544
    i32.load
    drop)
)
