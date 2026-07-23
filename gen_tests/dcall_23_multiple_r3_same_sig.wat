;; Three r3 functions with identical i32→i32 signature
;; Expected events: distinct IC/IR for each function
(module
  (memory (export "mem") 1)
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    i32.const 10
    call $r3_func_a
    drop
    i32.const 20
    call $r3_func_b
    drop
    i32.const 30
    call $r3_func_c
    drop)
  (func $r3_func_a (param i32) (result i32)
    local.get 0
    i32.const 100
    i32.add)
  (func $r3_func_b (param i32) (result i32)
    local.get 0
    i32.const 200
    i32.add)
  (func $r3_func_c (param i32) (result i32)
    local.get 0
    i32.const 300
    i32.add))
