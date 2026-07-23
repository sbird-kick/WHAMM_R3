;; Intent: real code grows 1 page, stores and loads in new page
;; Expected events: EC (no MG since real code grows, no L since shadow updated)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 1
    memory.grow
    drop
    i32.const 65536
    i32.const 42
    i32.store
    i32.const 65536
    i32.load
    drop)
)
