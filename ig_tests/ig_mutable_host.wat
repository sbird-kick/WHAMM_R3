(module
  (global $g (export "g") (mut i32) (i32.const 10))
  (func (export "modify")
    i32.const 20
    global.set $g
  )
)
