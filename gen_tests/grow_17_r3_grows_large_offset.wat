;; Intent: r3_main grows, stores at large offset in new page
;; Expected events: EC, MG, L
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 2
    memory.grow
    drop
    i32.const 131000
    i32.const 0xEE
    i32.store
    call $work)
  (func $work (export "work")
    i32.const 131000
    i32.load
    drop)
)
