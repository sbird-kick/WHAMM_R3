(module
  (import "s7_ig06_host" "g0" (global $g0 (mut i64)))
  (func (export "_start")
    global.get $g0
    drop
    global.get $g0
    i64.const 551
    i64.add
    global.set $g0
    global.get $g0
    drop
  )
)
