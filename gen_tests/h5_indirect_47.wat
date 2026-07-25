;; h5_indirect_47: Deep stack with indirect call
(module
  (memory (export "memory") 1)
  (type $i32_i32 (func (param i32) (result i32)))
  (table 2 funcref)
  (elem (i32.const 0) $r3_process)
  
  (func $r3_main (export "_start") (export "main")
    call $app_work)
  
  (func $r3_process (type $i32_i32)
    local.get 0 i32.const 2 i32.mul)
  
  (func $app_work (export "app_work")
    i32.const 1
    i32.const 2
    i32.add
    i32.const 3
    i32.mul
    i32.const 0 call_indirect (type $i32_i32)
    drop))
