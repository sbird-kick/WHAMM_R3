;; icall_05_mutual_indirect.wat
;; Two real functions call each other indirectly (bounded)
;; Expected: EC (r3_main->work_a), IC calls between work_a/work_b
(module
  (memory (export "mem") 1)
  (type $i32_void (func (param i32)))
  (table 2 funcref)
  (elem (i32.const 0) $work_a $work_b)

  (func $work_a (export "work_a") (param $counter i32)
    local.get $counter
    i32.const 0
    i32.gt_s
    if
      local.get $counter
      i32.const 1
      i32.sub
      i32.const 1
      call_indirect (type $i32_void)
    end)

  (func $work_b (export "work_b") (param $counter i32)
    local.get $counter
    i32.const 0
    i32.gt_s
    if
      local.get $counter
      i32.const 1
      i32.sub
      i32.const 0
      call_indirect (type $i32_void)
    end)

  (func $r3_main (export "_start")
    i32.const 3
    call $work_a)
)
