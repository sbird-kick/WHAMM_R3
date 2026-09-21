(module
  ;; The start function is ALSO the exported entry point, so the engine runs it
  ;; twice (once at instantiation, once as the entry). whamm injects @init and
  ;; the wasm:report hook into the start function, so both fire twice too —
  ;; print_trace must emit only events recorded since its last call, or the
  ;; second report re-dumps the first one's events as phantom duplicates.
  (memory 1)
  (global $n (mut i32) (i32.const 0))
  (func $helper (param i32) (result i32)
    local.get 0)
  (func $main (export "main")
    global.get $n
    i32.const 1
    i32.add
    global.set $n
    i32.const 7
    call $helper
    drop)
  (start $main))
