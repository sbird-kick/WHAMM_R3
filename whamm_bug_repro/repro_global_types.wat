(module
  (global (mut i64) (i64.const 0))
  (global (mut i32) (i32.const 0))
  (func (export "_start")
    i64.const 1
    global.set 0
    i32.const 2
    global.set 1)
  (memory (export "memory") 1))
