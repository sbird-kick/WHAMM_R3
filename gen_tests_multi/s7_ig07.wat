(module
  (import "s7_ig07_host" "g0" (global $g0 (mut f32)))
  (func (export "_start")
    global.get $g0
    drop
  )
)
