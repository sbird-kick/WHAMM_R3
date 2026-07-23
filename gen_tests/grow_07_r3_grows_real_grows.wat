;; Intent: r3_main grows, calls real function which also grows and stores/loads
;; Expected events: EC (for work), MG (from r3_main), no MG from real grow
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 1
    memory.grow
    drop
    call $work)
  (func $work (export "work")
    i32.const 1
    memory.grow
    drop
    i32.const 131072
    i32.const 77
    i32.store
    i32.const 131072
    i32.load
    drop)
)
