;; F32 store: r3 stores 0.5 (exact binary), app loads and uses it
;; Derived from seed 2207: 0.5 is exact f32
;; Expected: EC event (call to work)
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 0 f32.const 0.5 f32.store
    call $work)
  (func $work (export "work")
    i32.const 0 f32.load drop))
