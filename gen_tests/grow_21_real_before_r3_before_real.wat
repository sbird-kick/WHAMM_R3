;; Intent: real grows, r3_main grows, real grows again
;; Expected events: EC (real grow), EC (with MG from r3), EC (real grow)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $work
    i32.const 1
    memory.grow
    drop
    call $peek)
  (func $work (export "work")
    i32.const 1
    memory.grow
    drop)
  (func $peek (export "peek")
    i32.const 1
    memory.grow
    drop)
)
