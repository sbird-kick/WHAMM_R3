(module
  (import "ig_mutable_host" "g" (global $g (mut i32)))
  (import "ig_mutable_host" "modify" (func $modify))
  (func (export "_start")
    global.get $g
    drop
    call $modify
    global.get $g
    drop
  )
)
