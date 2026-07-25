;; inner loop breaks to labelled outer block after loading (block carries i32)
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    call $r3_poke call $app_nlb drop)
  (func $r3_poke i32.const 3680 i32.const 4040 i32.store)
  (func $app_nlb (export "app_nlb") (result i32)
    (block $done (result i32)
      (loop $o
        (loop $i
          i32.const 3680 i32.load
          br $done))
      i32.const 0)))
