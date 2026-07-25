(module
  (global $st (mut i32) (i32.const 0))
  (func (export "advance") (result i32)
    ;; state = (state + 1) mod 3
    global.get $st
    i32.const 1
    i32.add
    i32.const 3
    i32.rem_u
    global.set $st
    global.get $st)
  (func (export "state") (result i32)
    global.get $st)
)
