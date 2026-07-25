;; multivalue loop carrying two values (acc,i); load feeds acc; runs 3 iters
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_mvl drop)
  (func $r3_poke i32.const 1200 i32.const 4 i32.store)
  (func $app_mvl (export "app_mvl") (result i32)
    (local $i i32)
    i32.const 0            ;; acc
    (loop $lp (param i32) (result i32)
      i32.const 1200 i32.load
      i32.add                              ;; acc += mem  -> stack: acc'
      local.get $i i32.const 1 i32.add local.tee $i
      i32.const 3 i32.lt_s
      br_if $lp)))
