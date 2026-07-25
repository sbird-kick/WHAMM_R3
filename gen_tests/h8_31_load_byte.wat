;; h8_31_load_byte: Load single byte divergence
(module
  (memory (export "memory") 1)
  (func $r3_main (export "_start") (export "main")
    i32.const 100 i32.const 42 i32.store8
    call $app_read_byte)
  (func $app_read_byte (export "app_read_byte")
    i32.const 100 i32.load8_u drop))
