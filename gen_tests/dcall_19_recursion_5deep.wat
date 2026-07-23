;; Recursion: self-call 5 times, only outermost is EC
;; Expected events: EC for $recurse once (depth 0), no EC for nested calls
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 5
    call $recurse)
  (func $recurse (export "recurse") (param i32) (local $n i32)
    local.get 0
    local.set $n
    local.get $n
    i32.const 0
    i32.gt_s
    if
      local.get $n
      i32.const 1
      i32.sub
      call $recurse
    end))
