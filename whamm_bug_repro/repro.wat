(module
  (func $with_params (export "with_params") (param i32 i32)
    return
  )
  (func $no_params (export "no_params")
    return
  )
  (func $_start (export "_start")
    i32.const 1
    i32.const 2
    call $with_params
    call $no_params
  )
)
