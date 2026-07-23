;; Intent: r3_main grows and stores in original page, real loads from original
;; Expected events: EC, MG, L (load from original page where r3 wrote)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 1
    memory.grow
    drop
    i32.const 0
    i32.const 0xCC
    i32.store
    call $work)
  (func $work (export "work")
    i32.const 0
    i32.load
    drop)
)
