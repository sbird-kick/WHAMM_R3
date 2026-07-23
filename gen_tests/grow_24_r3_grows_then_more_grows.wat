;; Intent: r3_main grows, calls real which grows, then r3_main grows again
;; Expected events: EC (with first MG), EC (with second MG)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 1
    memory.grow
    drop
    call $work
    i32.const 1
    memory.grow
    drop
    call $peek)
  (func $work (export "work")
    i32.const 2
    memory.grow
    drop)
  (func $peek (export "peek"))
)
