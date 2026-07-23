;; icall_03_r3_ec_direct.wat
;; r3_main directly calls real function (direct EC, not via indirect)
;; Expected: EC (r3_main->work)
(module
  (memory (export "mem") 1)

  (func $work (export "work"))

  (func $r3_main (export "_start")
    call $work)
)
