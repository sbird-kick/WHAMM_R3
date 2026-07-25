;; s8_04_brtable_straddle3
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke3
    call $app_load3)
  (func $r3_poke3
    i32.const 127 i32.const 203 i32.store8)  ;; single byte at top of word
  (func $app_load3 (export "app_load3")
    (local $x i32)
    block $b0
      block $b1
        block $b2
          i32.const 0
          br_table $b0 $b1 $b2
        end
        i32.const 124 i32.load local.set $x
        br $b0
      end
      i32.const 124 i32.load local.set $x
    end
    local.get $x drop)
)
