;; Intent: r3_main grows, stores at offset 4, real loads offset 0 and 4
;; Expected events: EC, MG, L (only for offset 4 which was written by r3)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 1
    memory.grow
    drop
    i32.const 65540
    i32.const 0xFF
    i32.store
    call $work)
  (func $work (export "work")
    i32.const 65536
    i32.load
    drop
    i32.const 65540
    i32.load
    drop)
)
