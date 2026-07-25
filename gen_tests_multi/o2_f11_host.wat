(module
  (global $s (mut i32) (i32.const 18))
  (func (export "f0") (result i32) global.get $s i32.const 5 i32.xor global.set $s global.get $s)
  (func (export "f1") (result i32) global.get $s i32.const 3 i32.xor global.set $s global.get $s)
  (func (export "f2") (result i32) global.get $s i32.const 9 i32.mul global.set $s global.get $s)
)
