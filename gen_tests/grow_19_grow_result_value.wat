;; Intent: r3_main grows, stores result value, real code loads it
;; Expected events: EC, MG, L (load of the stored result)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 1
    memory.grow
    i32.const 0
    i32.store
    call $work)
  (func $work (export "work")
    i32.const 0
    i32.load
    drop)
)
