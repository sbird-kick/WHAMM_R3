;; icall_04_self_recursive.wat
;; Real function recursively calls itself indirectly (bounded)
;; Expected: EC (r3_main->work), multiple IC->work via indirect
(module
  (memory (export "mem") 1)
  (type $i32_void (func (param i32)))
  (table 1 funcref)
  (elem (i32.const 0) $work)

  (func $work (export "work") (param $counter i32)
    local.get $counter
    i32.const 1
    i32.sub
    local.tee $counter
    i32.const 0
    i32.gt_s
    if
      local.get $counter
      i32.const 0
      call_indirect (type $i32_void)
    end)

  (func $r3_main (export "_start")
    i32.const 4
    call $work)
)
