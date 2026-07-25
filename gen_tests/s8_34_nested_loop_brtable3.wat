;; s8_34_nested_loop_brtable3
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke3
    call $app_work3)
  (func $r3_poke3
    i32.const 1032 i32.const 8 i32.store8)
  (func $app_work3 (export "app_work3")
    (local $i i32) (local $j i32) (local $acc i32)
    i32.const 0 local.set $i
    loop $outer
      i32.const 0 local.set $j
      loop $inner
        block $bt
          block $b0
            block $b1
              block $b2
                local.get $j
                br_table $b0 $b1 $b2
              end
              local.get $acc i32.const 1 i32.add local.set $acc
              br $bt
            end
            local.get $acc i32.const 2 i32.add local.set $acc
            br $bt
          end
          local.get $acc i32.const 3 i32.add local.set $acc
        end
        local.get $j i32.const 1 i32.add local.tee $j
        i32.const 3 i32.lt_s
        br_if $inner
      end
      local.get $i i32.const 1 i32.add local.tee $i
      i32.const 2 i32.lt_s
      br_if $outer
    end
    i32.const 1030 i32.load drop
    local.get $acc drop)
)
