;; br_table with many targets, each block loads a different addr
;; all targets have arity [] (loads happen after the target label, no br value)
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    i32.const 0 call $app_bt drop
    i32.const 1 call $app_bt drop
    i32.const 2 call $app_bt drop
    i32.const 3 call $app_bt drop)
  (func $r3_poke
    i32.const 880 i32.const 10 i32.store
    i32.const 888 i32.const 20 i32.store
    i32.const 896 i32.const 30 i32.store
    i32.const 904 i32.const 40 i32.store)
  (func $app_bt (export "app_bt") (param $s i32) (result i32)
    (block $b3
      (block $b2
        (block $b1
          (block $b0
            local.get $s
            br_table $b0 $b1 $b2 $b3 $b0)
          i32.const 880 i32.load return)
        i32.const 888 i32.load return)
      i32.const 896 i32.load return)
    i32.const 904 i32.load))
