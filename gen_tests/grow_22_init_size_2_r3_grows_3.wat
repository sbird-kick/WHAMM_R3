;; Intent: initial size 2, r3_main grows 3 pages
;; Expected events: EC, MG
(module
  (memory (export "mem") 2)
  (func $r3_main (export "_start")
    i32.const 3
    memory.grow
    drop
    call $work)
  (func $work (export "work"))
)
