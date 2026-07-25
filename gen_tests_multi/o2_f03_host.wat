(module
  (global $s (mut i32) (i32.const 12))
  (func (export "f0") (result i32) global.get $s i32.const 35 i32.or global.set $s global.get $s)
  (func (export "f1") (result i32) global.get $s i32.const 33 i32.or global.set $s global.get $s)
  (func (export "f2") (result i32) global.get $s i32.const 23 i32.or global.set $s global.get $s)
)
