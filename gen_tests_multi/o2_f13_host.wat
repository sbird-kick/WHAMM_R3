(module
  (global $s (mut i32) (i32.const 2))
  (func (export "f0") (result i32) global.get $s i32.const 9 i32.or global.set $s global.get $s)
  (func (export "f1") (result i32) global.get $s i32.const 7 i32.mul global.set $s global.get $s)
  (func (export "f2") (result i32) global.get $s i32.const 13 i32.xor global.set $s global.get $s)
  (func (export "f3") (result i32) global.get $s i32.const 35 i32.sub global.set $s global.get $s)
  (func (export "f4") (result i32) global.get $s i32.const 25 i32.xor global.set $s global.get $s)
)
