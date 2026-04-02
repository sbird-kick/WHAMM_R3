(module
  (import "ig_with_calls_host" "g" (global $g i32))
  (import "ig_with_calls_host" "helper" (func $helper (result i32)))
  (func (export "_start")
    global.get $g
    drop
    call $helper
    drop
  )
)
