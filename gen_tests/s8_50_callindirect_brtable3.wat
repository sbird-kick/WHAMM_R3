;; s8_50_callindirect_brtable3
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_call3)
  (table 2 funcref)
  (elem (i32.const 0) $host_fn3 $app_fn3)
  (type $ty (func (result i32)))
  (func $host_fn3 (result i32) i32.const 103)
  (func $app_fn3 (export "app_fn3") (result i32)
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
  (func $r3_call3
    call $app_fn3 drop)
)
