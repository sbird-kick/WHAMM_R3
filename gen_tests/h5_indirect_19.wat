;; h5_indirect_19: App reads exported global after indirect call to r3
(module
  (memory (export "memory") 1)
  (global $data (export "data") (mut i32) (i32.const 100))
  (type $void_void (func))
  (table 2 funcref)
  (elem (i32.const 0) $r3_mod_global)
  
  (func $r3_main (export "_start") (export "main")
    call $app_caller)
  
  (func $r3_mod_global (type $void_void)
    i32.const 200 global.set $data)
  
  (func $app_caller (export "app_caller")
    i32.const 0 call_indirect (type $void_void)
    global.get $data drop))
