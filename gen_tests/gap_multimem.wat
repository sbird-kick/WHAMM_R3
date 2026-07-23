(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (func $r3_poke (export "poke")
    ;; host-sim writes into memory 1 — invisible, must surface as L on load
    i32.const 8
    i32.const 123
    i32.store $m1)
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    call $r3_poke
    ;; load from memory 1 observes host write → oracle should emit L;1;8;...
    i32.const 8
    i32.load $m1
    drop)
)
