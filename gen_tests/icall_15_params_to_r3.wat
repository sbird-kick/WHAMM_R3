;; icall_15_params_to_r3.wat
;; Call_indirect to r3 function with i32 parameters
;; Expected: EC, IC with param values recorded, IR
(module
  (memory (export "mem") 1)
  (type $i32_void (func (param i32)))
  (table 1 funcref)
  (elem (i32.const 0) $r3_param_fn)

  (func $r3_param_fn (param i32))

  (func $work (export "work")
    i32.const 123
    i32.const 0
    call_indirect (type $i32_void))

  (func $r3_main (export "_start")
    call $work)
)
