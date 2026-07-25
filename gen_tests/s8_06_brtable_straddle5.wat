;; s8_06_brtable_straddle5
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke5
    call $app_load5)
  (func $r3_poke5
    i32.const 143 i32.const 205 i32.store8)  ;; single byte at top of word
  (func $app_load5 (export "app_load5")
    (local $x i32)
    block $b0
      block $b1
        block $b2
          i32.const 2
          br_table $b0 $b1 $b2
        end
        i32.const 140 i32.load local.set $x
        br $b0
      end
      i32.const 140 i32.load local.set $x
    end
    local.get $x drop)
)
