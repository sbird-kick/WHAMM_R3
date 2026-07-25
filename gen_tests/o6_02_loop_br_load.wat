;; Loop with br carrying result, load each iter -> multiple L
(module
  (memory (export "memory") 1)
  (global $sum (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_loop drop)
  (func $r3_poke
    i32.const 160 i32.const 9606 i32.store
    i32.const 168 i32.const 606 i32.store)
  (func $app_loop (export "app_loop") (result i32)
    (local $i i32)
    (block $done (result i32)
      (loop $lp (result i32)
        i32.const 160 i32.load
        i32.const 168 i32.load i32.add
        local.get $i i32.const 1 i32.add local.tee $i
        i32.const 2 i32.lt_s
        br_if $lp
        br $done))))
