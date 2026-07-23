;; icall_24_three_way_indirect.wat
;; Three functions in cyclic indirect pattern
;; Expected: EC, multiple IC/IR pairs
(module
  (memory (export "mem") 1)
  (type $i32_void (func (param i32)))
  (table 3 funcref)
  (elem (i32.const 0) $a $b $c)

  (func $a (export "a") (param $n i32)
    local.get $n
    i32.const 0
    i32.gt_s
    if
      local.get $n
      i32.const 1
      i32.sub
      i32.const 1
      call_indirect (type $i32_void)
    end)

  (func $b (export "b") (param $n i32)
    local.get $n
    i32.const 0
    i32.gt_s
    if
      local.get $n
      i32.const 1
      i32.sub
      i32.const 2
      call_indirect (type $i32_void)
    end)

  (func $c (export "c") (param $n i32)
    local.get $n
    i32.const 0
    i32.gt_s
    if
      local.get $n
      i32.const 1
      i32.sub
      i32.const 0
      call_indirect (type $i32_void)
    end)

  (func $r3_main (export "_start")
    i32.const 4
    call $a)
)
