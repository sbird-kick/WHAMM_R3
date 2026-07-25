;; s8_02_brtable_straddle1
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke1
    call $app_load1)
  (func $r3_poke1
    i32.const 111 i32.const 201 i32.store8)  ;; single byte at top of word
  (func $app_load1 (export "app_load1")
    (local $x i32)
    block $b0
      block $b1
        block $b2
          i32.const 1
          br_table $b0 $b1 $b2
        end
        i32.const 108 i32.load local.set $x
        br $b0
      end
      i32.const 108 i32.load local.set $x
    end
    local.get $x drop)
)
