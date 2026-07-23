;; icall_16_params_to_real.wat
;; Call_indirect to real function with parameters
;; Expected: EC, no IC (real->real boundary)
(module
  (memory (export "mem") 1)
  (type $i32_void (func (param i32)))
  (table 1 funcref)
  (elem (i32.const 0) $helper)

  (func $helper (export "helper") (param i32))

  (func $work (export "work")
    i32.const 456
    i32.const 0
    call_indirect (type $i32_void))

  (func $r3_main (export "_start")
    call $work)
)
