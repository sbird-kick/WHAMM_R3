;; Intent: real code grows, stores at page boundary, loads
;; Expected events: EC (no MG since real code grows, no L since shadow updated)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 1
    memory.grow
    drop
    i32.const 65532
    i32.const 0xDD
    i32.store
    i32.const 65532
    i32.load
    drop)
)
