;; Intent: r3_main grows, stores at page boundary, real loads
;; Expected events: EC, MG, L
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 1
    memory.grow
    drop
    i32.const 65532
    i32.const 0xBB
    i32.store
    call $work)
  (func $work (export "work")
    i32.const 65532
    i32.load
    drop)
)
