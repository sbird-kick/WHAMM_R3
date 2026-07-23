;; Nonzero init value, never touched by host → no G event
(module
  (memory (export "mem") 1)
  (global $g (export "g") (mut i32) (i32.const 77))
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    global.get $g
    drop))
