;; bulk_21_init_drop: Init from one segment, drop another
(module
  (memory (export "mem") 1)
  (data $s1 "\44\55\66")
  (data $s2 "\aa\bb\cc")
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 100 i32.const 0 i32.const 3 memory.init $s1
    data.drop $s2
    i32.const 100 i32.load drop))
