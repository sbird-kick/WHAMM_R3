(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    i32.const 0 call $app_b20 drop
    i32.const 1 call $app_b20 drop
    i32.const 2 call $app_b20 drop
    i32.const 3 call $app_b20 drop
    i32.const 4 call $app_b20 drop
    i32.const 5 call $app_b20 drop
    i32.const 6 call $app_b20 drop
    i32.const 7 call $app_b20 drop
    i32.const 8 call $app_b20 drop
    i32.const 9 call $app_b20 drop
    i32.const 10 call $app_b20 drop
    i32.const 11 call $app_b20 drop
    i32.const 12 call $app_b20 drop
    i32.const 13 call $app_b20 drop
    i32.const 14 call $app_b20 drop
    i32.const 15 call $app_b20 drop
    i32.const 16 call $app_b20 drop
    i32.const 17 call $app_b20 drop
    i32.const 18 call $app_b20 drop
    i32.const 19 call $app_b20 drop
    )
  (func $r3_poke
    i32.const 4200 i32.const 1000 i32.store
    i32.const 4208 i32.const 1001 i32.store
    i32.const 4216 i32.const 1002 i32.store
    i32.const 4224 i32.const 1003 i32.store
    i32.const 4232 i32.const 1004 i32.store
    i32.const 4240 i32.const 1005 i32.store
    i32.const 4248 i32.const 1006 i32.store
    i32.const 4256 i32.const 1007 i32.store
    i32.const 4264 i32.const 1008 i32.store
    i32.const 4272 i32.const 1009 i32.store
    i32.const 4280 i32.const 1010 i32.store
    i32.const 4288 i32.const 1011 i32.store
    i32.const 4296 i32.const 1012 i32.store
    i32.const 4304 i32.const 1013 i32.store
    i32.const 4312 i32.const 1014 i32.store
    i32.const 4320 i32.const 1015 i32.store
    i32.const 4328 i32.const 1016 i32.store
    i32.const 4336 i32.const 1017 i32.store
    i32.const 4344 i32.const 1018 i32.store
    i32.const 4352 i32.const 1019 i32.store
    )
  (func $app_b20 (export "app_b20") (param $s i32) (result i32)
    (block $b19
    (block $b18
    (block $b17
    (block $b16
    (block $b15
    (block $b14
    (block $b13
    (block $b12
    (block $b11
    (block $b10
    (block $b9
    (block $b8
    (block $b7
    (block $b6
    (block $b5
    (block $b4
    (block $b3
    (block $b2
    (block $b1
    (block $b0
      local.get $s
      br_table $b0 $b1 $b2 $b3 $b4 $b5 $b6 $b7 $b8 $b9 $b10 $b11 $b12 $b13 $b14 $b15 $b16 $b17 $b18 $b19 $b0)
    i32.const 4200 i32.load return)
    i32.const 4208 i32.load return)
    i32.const 4216 i32.load return)
    i32.const 4224 i32.load return)
    i32.const 4232 i32.load return)
    i32.const 4240 i32.load return)
    i32.const 4248 i32.load return)
    i32.const 4256 i32.load return)
    i32.const 4264 i32.load return)
    i32.const 4272 i32.load return)
    i32.const 4280 i32.load return)
    i32.const 4288 i32.load return)
    i32.const 4296 i32.load return)
    i32.const 4304 i32.load return)
    i32.const 4312 i32.load return)
    i32.const 4320 i32.load return)
    i32.const 4328 i32.load return)
    i32.const 4336 i32.load return)
    i32.const 4344 i32.load return)
    i32.const 4352 i32.load))
