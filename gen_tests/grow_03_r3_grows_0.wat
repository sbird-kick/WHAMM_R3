;; Intent: r3_main grows 0 pages, calls exported real function
;; Expected events: EC (no MG since growth=0)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 0
    memory.grow
    drop
    call $work)
  (func $work (export "work"))
)
