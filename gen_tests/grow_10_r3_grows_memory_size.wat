;; Intent: r3_main grows, real code reads memory.size
;; Expected events: EC, MG (no L since size is metadata, not a memory load)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 1
    memory.grow
    drop
    call $work)
  (func $work (export "work")
    memory.size
    drop)
)
