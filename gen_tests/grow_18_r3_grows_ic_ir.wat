;; Intent: r3_main grows, calls real, which calls back to r3 (IC), then IR
;; Expected events: EC, MG, IC, IR
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 1
    memory.grow
    drop
    call $work)
  (func $work (export "work")
    call $r3_helper)
  (func $r3_helper
    i32.const 42
    drop)
)
