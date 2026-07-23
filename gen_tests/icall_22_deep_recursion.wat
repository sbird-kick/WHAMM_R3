;; icall_22_deep_recursion.wat
;; Deeper bounded recursion via indirect calls
;; Expected: EC, multiple IC/IR pairs
(module
  (memory (export "mem") 1)
  (type $i32_void (func (param i32)))
  (table 1 funcref)
  (elem (i32.const 0) $recurse)

  (func $recurse (export "recurse") (param $depth i32)
    local.get $depth
    i32.const 0
    i32.gt_s
    if
      local.get $depth
      i32.const 1
      i32.sub
      i32.const 0
      call_indirect (type $i32_void)
    end)

  (func $r3_main (export "_start")
    i32.const 5
    call $recurse)
)
