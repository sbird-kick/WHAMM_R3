;; Unexported mutable global: no G events even if host modifies it
(module
  (memory (export "mem") 1)
  (global $hidden (mut i32) (i32.const 0))
  (func $r3_main (export "_start")
    i32.const 88
    global.set $hidden
    call $work)
  (func $work (export "work")
    global.get $hidden
    drop))
