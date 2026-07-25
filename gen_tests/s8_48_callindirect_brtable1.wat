;; s8_48_callindirect_brtable1
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_call1)
  (table 2 funcref)
  (elem (i32.const 0) $host_fn1 $app_fn1)
  (type $ty (func (result i32)))
  (func $host_fn1 (result i32) i32.const 101)
  (func $app_fn1 (export "app_fn1") (result i32)
    (local $v i32)
    block $b0
      block $b1
        i32.const 1
        br_table $b0 $b1
      end
      i32.const 1
      call_indirect (type $ty)
      local.set $v
      br $b0
    end
    local.get $v)
  (func $r3_call1
    call $app_fn1 drop)
)
