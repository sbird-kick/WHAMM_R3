(module
  (import "s7_ig01_host" "g0" (global $g0 i32))
  (func (export "_start")
    global.get $g0
    drop
  )
)
