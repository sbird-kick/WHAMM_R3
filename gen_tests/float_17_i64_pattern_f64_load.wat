;; i64 bit pattern via f64 load: real writes i64 bits, reads as f64
;; Expected: no L event (real code wrote it)
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 0 i64.const 0x4005be0a3b645a00 i64.store
    i32.const 0 f64.load drop)
)
