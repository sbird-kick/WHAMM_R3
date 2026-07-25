;; s8_03_brtable_straddle2
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke2
    call $app_load2)
  (func $r3_poke2
    i32.const 119 i32.const 202 i32.store8)  ;; single byte at top of word
  (func $app_load2 (export "app_load2")
    (local $x i32)
    block $b0
      block $b1
        block $b2
          i32.const 2
          br_table $b0 $b1 $b2
        end
        i32.const 116 i32.load local.set $x
        br $b0
      end
      i32.const 116 i32.load local.set $x
    end
    local.get $x drop)
)
