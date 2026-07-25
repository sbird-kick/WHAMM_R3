;; h8_32_load_word: Load 2-byte word
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 200 i32.const 5000 i32.store16
    call $app_read_word)
  (func $app_read_word (export "app_read_word")
    i32.const 200 i32.load16_u drop))
