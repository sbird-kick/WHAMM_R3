(module
  (import "s7_ig08_host" "g0" (global $g0 (mut f64)))
  (func (export "_start")
    global.get $g0
    drop
  )
)
