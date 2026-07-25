;; br to outer block label from inside if, carrying loaded value
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_bo drop)
  (func $r3_poke i32.const 3360 i32.const 909 i32.store)
  (func $app_bo (export "app_bo") (result i32)
    (block $out (result i32)
      (block $in
        (if (i32.const 1)
          (then i32.const 3360 i32.load br $out)))
      i32.const 0)))
