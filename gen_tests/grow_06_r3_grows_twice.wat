;; Intent: r3_main grows twice sequentially before calling real function
;; Expected events: EC, MG (detect total growth)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 1
    memory.grow
    drop
    i32.const 1
    memory.grow
    drop
    call $work)
  (func $work (export "work"))
)
