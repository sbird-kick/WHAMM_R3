(module
  (memory (export "mem") 1)
  (data (i32.const 0) "\01\02\03\04")
  (data $p "\aa\bb\cc\dd")
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    ;; module code runs memory.init from a passive segment — deterministic,
    ;; oracle should emit NO L event for the subsequent load
    i32.const 100 i32.const 0 i32.const 4 memory.init $p
    i32.const 100 i32.load drop
    ;; also load the active-segment region (control: never an L event)
    i32.const 0 i32.load drop)
)
