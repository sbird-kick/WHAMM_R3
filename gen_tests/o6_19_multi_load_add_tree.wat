;; several loads combined in an expression tree inside a block
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke
    call $app_tree drop)
  (func $r3_poke
    i32.const 1440 i32.const 1 i32.store
    i32.const 1448 i32.const 2 i32.store
    i32.const 1456 i32.const 3 i32.store
    i32.const 1464 i32.const 4 i32.store)
  (func $app_tree (export "app_tree") (result i32)
    (block $b (result i32)
      (i32.add
        (i32.add (i32.load (i32.const 1440)) (i32.load (i32.const 1448)))
        (i32.add (i32.load (i32.const 1456)) (i32.load (i32.const 1464)))))))
