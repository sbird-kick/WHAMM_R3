;; Intent: r3_main grows 1 page, calls exported real function
;; Expected events: EC, MG
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 1
    memory.grow
    drop
    call $work)
  (func $work (export "work"))
)
