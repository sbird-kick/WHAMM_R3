;; br_table where all entries point to same target, load after
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    i32.const 5 call $app_bts drop)
  (func $r3_poke i32.const 1120 i32.const 321 i32.store)
  (func $app_bts (export "app_bts") (param $s i32) (result i32)
    (block $t
      local.get $s
      br_table $t $t $t $t)
    i32.const 1120 i32.load))
