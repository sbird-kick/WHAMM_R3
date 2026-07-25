;; loop interleaving a load (L) and a host call (IC/IR) each iteration
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_li)
  (func $r3_poke i32.const 2080 i32.const 5 i32.store)
  (func $r3_tick nop)
  (func $app_li (export "app_li")
    (local $i i32)
    (loop $lp
      i32.const 2080 i32.load drop
      call $r3_tick
      local.get $i i32.const 1 i32.add local.tee $i
      i32.const 3 i32.lt_s br_if $lp)))
