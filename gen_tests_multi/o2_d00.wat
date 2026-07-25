(module
  (import "o2_d00_host" "advance" (func $advance (result i32)))
  (import "o2_d00_host" "state" (func $state (result i32)))
  (func (export "_start")
    call $advance
    drop
    call $state
    drop
    call $advance
    drop
    call $advance
    drop
    call $state
    drop
    call $advance
    drop
    call $advance
    drop
    call $state
    drop
    call $advance
    drop
  )
)
