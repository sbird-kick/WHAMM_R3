;; Indirect recursion: real→r3→real with recursion
;; Expected events: EC for $countdown, IC/IR for $r3_helper
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 3
    call $countdown)
  (func $countdown (export "countdown") (param i32)
    local.get 0
    i32.const 0
    i32.gt_s
    if
      local.get 0
      call $r3_helper
    end)
  (func $r3_helper (param i32)
    local.get 0
    i32.const 1
    i32.sub
    call $countdown))
