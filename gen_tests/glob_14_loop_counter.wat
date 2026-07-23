;; Global loop counter in real code while host mutates different global
(module
  (memory (export "mem") 1)
  (global $counter (export "counter") (mut i32) (i32.const 0))
  (global $hostval (export "hostval") (mut i32) (i32.const 0))
  (func $r3_main (export "_start")
    i32.const 42
    global.set $hostval
    call $work)
  (func $work (export "work")
    (local $i i32)
    i32.const 0
    local.set $i
    block $break
      loop $continue
        local.get $i
        i32.const 3
        i32.ge_u
        br_if $break
        local.get $i
        i32.const 1
        i32.add
        local.set $i
        br $continue
      end
    end
    global.get $hostval
    drop))
