(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main") call $r3_poke i32.const 400 call $app_rec drop)
  (func $r3_poke i32.const 8 i32.const 9505 i32.store)
  (func $app_rec (export "app_rec") (param $n i32) (result i32)
    local.get $n i32.eqz if (result i32) i32.const 8 i32.load else local.get $n i32.const 1 i32.sub call $app_rec end)
)