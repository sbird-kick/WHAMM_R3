;; Intent: r3_main grows 3 pages sequentially
;; Expected events: EC, MG
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 3
    memory.grow
    drop
    call $work)
  (func $work (export "work"))
)
