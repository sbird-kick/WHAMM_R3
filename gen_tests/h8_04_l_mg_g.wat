;; h8_04_l_mg_g: L + MG + G
;; r3_main writes memory and global, calls app_work, app grows memory and reads both
(module
  (memory (export "memory") 1)
  (global $g1 (export "g1") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 32 i32.const 135 i32.store
    i32.const 23 global.set $g1
    call $app_work)
  (func $app_work (export "app_work")
    i32.const 3 memory.grow drop
    i32.const 32 i32.load drop
    global.get $g1 drop))
