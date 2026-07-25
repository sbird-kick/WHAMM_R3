(module
  (global (export "g") (mut i32) (i32.const 9202))
  (func (export "bump") (param i32) (result i32)
    global.get 0
    local.get 0
    i32.add
    global.set 0
    global.get 0
  )
)
