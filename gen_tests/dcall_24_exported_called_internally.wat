;; Exported real function called both from r3 (EC) and internally (no EC)
;; Expected events: EC for $exposed once (from r3), no EC for internal call at depth 1
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $exposed)
  (func $exposed (export "exposed")
    call $internal)
  (func $internal
    call $exposed))
