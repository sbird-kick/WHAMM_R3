;; Intent: memory starts with 3 pages, r3_main grows 2 pages
;; Expected events: EC, MG
(module
  (memory (export "mem") 3)
  (func $r3_main (export "_start")
    i32.const 2
    memory.grow
    drop
    call $work)
  (func $work (export "work"))
)
