;; multivalue block (i32,i64) feeding ops; locals declared up front
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_mix drop)
  (func $r3_poke
    i32.const 560 i32.const 123 i32.store
    i32.const 568 i64.const 4567 i64.store)
  (func $app_mix (export "app_mix") (result i64)
    (local $a i32) (local $b i64)
    (block $bl (result i32 i64)
      i32.const 560 i32.load
      i32.const 568 i64.load)
    local.set $b
    local.set $a
    local.get $a i64.extend_i32_s
    local.get $b
    i64.add))
