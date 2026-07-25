;; h8_38_global_export_import: Exported global modified and read
(module
  (memory (export "memory") 1)
  (global $gj (export "gj") (mut i32) (i32.const 0))
  (func $r3_main (export "_start") (export "main")
    i32.const 999 global.set $gj
    call $app_read_global)
  (func $app_read_global (export "app_read_global")
    global.get $gj drop))
