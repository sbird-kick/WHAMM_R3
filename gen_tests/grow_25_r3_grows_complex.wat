;; Intent: r3_main grows, stores in new page at specific offset, real loads unchanged nearby
;; Expected events: EC, MG, L (only for stored offset)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 1
    memory.grow
    drop
    i32.const 65556
    i32.const 0x11
    i32.store
    call $work)
  (func $work (export "work")
    i32.const 65548
    i32.load
    drop
    i32.const 65556
    i32.load
    drop
    i32.const 65560
    i32.load
    drop)
)
