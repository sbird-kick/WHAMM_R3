;; two nested loops, inner loads, outer accumulates -> multiple L
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_dl drop)
  (func $r3_poke i32.const 960 i32.const 3 i32.store)
  (func $app_dl (export "app_dl") (result i32)
    (local $i i32) (local $j i32) (local $acc i32)
    (loop $outer
      i32.const 0 local.set $j
      (loop $inner
        i32.const 960 i32.load
        local.get $acc i32.add local.set $acc
        local.get $j i32.const 1 i32.add local.tee $j
        i32.const 2 i32.lt_s br_if $inner)
      local.get $i i32.const 1 i32.add local.tee $i
      i32.const 2 i32.lt_s br_if $outer)
    local.get $acc))
