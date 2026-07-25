(module
  (global $s (mut i32) (i32.const 8))
  (func (export "f0") (result i32) global.get $s i32.const 27 i32.sub global.set $s global.get $s)
  (func (export "f1") (result i32) global.get $s i32.const 25 i32.mul global.set $s global.get $s)
  (func (export "f2") (result i32) global.get $s i32.const 39 i32.xor global.set $s global.get $s)
)
