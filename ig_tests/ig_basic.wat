(module
  (import "ig_basic_host" "g" (global $g i32))
  (func (export "_start")
    global.get $g
    drop
  )
)
