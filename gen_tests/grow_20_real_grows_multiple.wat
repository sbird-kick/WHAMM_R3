;; Intent: real code grows multiple times sequentially
;; Expected events: EC (no MG since real code grows)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 1
    memory.grow
    drop
    i32.const 1
    memory.grow
    drop
    memory.size
    drop)
)
