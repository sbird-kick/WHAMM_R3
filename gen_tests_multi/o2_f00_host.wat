(module
  (global $s (mut i32) (i32.const 8))
  (func (export "f0") (result i32) global.get $s i32.const 3 i32.sub global.set $s global.get $s)
  (func (export "f1") (result i32) global.get $s i32.const 1 i32.or global.set $s global.get $s)
  (func (export "f2") (result i32) global.get $s i32.const 39 i32.add global.set $s global.get $s)
  (func (export "f3") (result i32) global.get $s i32.const 21 i32.xor global.set $s global.get $s)
  (func (export "f4") (result i32) global.get $s i32.const 19 i32.or global.set $s global.get $s)
)
