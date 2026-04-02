(module
  (import "ig_multi_type_host" "gi" (global $gi i32))
  (import "ig_multi_type_host" "gl" (global $gl i64))
  (import "ig_multi_type_host" "gf" (global $gf f64))
  (func (export "_start")
    global.get $gi
    drop
    global.get $gl
    drop
    global.get $gf
    drop
  )
)
