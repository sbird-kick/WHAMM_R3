;; s8_01_brtable_straddle0
(module
  (memory (export "memory") 1)
  
  (func $r3_main (export "_start") (export "main")
    call $r3_poke0
    call $app_load0)
  (func $r3_poke0
    i32.const 103 i32.const 200 i32.store8)  ;; single byte at top of word
  (func $app_load0 (export "app_load0")
    (local $x i32)
    block $b0
      block $b1
        block $b2
          i32.const 0
          br_table $b0 $b1 $b2
        end
        i32.const 100 i32.load local.set $x
        br $b0
      end
      i32.const 100 i32.load local.set $x
    end
    local.get $x drop)
)
