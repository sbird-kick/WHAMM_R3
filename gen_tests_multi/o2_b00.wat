(module
  (import "o2_b00_host" "tick" (func $tick (param i32) (result i32)))
  (import "o2_b00_host" "peek" (func $peek (result i32)))
  (func (export "_start") (local $i i32)
    (loop $L
      i32.const 6
      call $tick
      drop
      local.get $i
      i32.const 1
      i32.add
      local.tee $i
      i32.const 11
      i32.lt_s
      br_if $L)
    call $peek
    drop
  )
)
