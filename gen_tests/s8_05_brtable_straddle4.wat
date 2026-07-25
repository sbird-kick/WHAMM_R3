;; s8_05_brtable_straddle4
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke4
    call $app_load4)
  (func $r3_poke4
    i32.const 135 i32.const 204 i32.store8)  ;; single byte at top of word
  (func $app_load4 (export "app_load4")
    (local $x i32)
    block $b0
      block $b1
        block $b2
          i32.const 1
          br_table $b0 $b1 $b2
        end
        i32.const 132 i32.load local.set $x
        br $b0
      end
      i32.const 132 i32.load local.set $x
    end
    local.get $x drop)
)
