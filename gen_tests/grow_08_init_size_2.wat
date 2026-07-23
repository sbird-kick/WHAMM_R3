;; Intent: memory starts with 2 pages, r3_main grows 1 page
;; Expected events: EC, MG
(module
  (memory (export "mem") 2)
  (func $r3_main (export "_start")
    i32.const 1
    memory.grow
    drop
    call $work)
  (func $work (export "work"))
)
