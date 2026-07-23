;; Mutual recursion: two functions calling each other recursively
;; Expected events: EC for $even once (from r3_main), IC/IR for calls to $r3_odd
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    i32.const 3
    call $even)
  (func $even (export "even") (param i32)
    local.get 0
    i32.const 0
    i32.eq
    if
      return
    end
    local.get 0
    i32.const 1
    i32.sub
    call $r3_odd)
  (func $r3_odd (param i32)
    local.get 0
    i32.const 0
    i32.eq
    if
      return
    end
    local.get 0
    i32.const 1
    i32.sub
    call $even))
