;; LENS: control-flow that breaks call_depth bookkeeping (E: unwinding).
;;
;; MECHANISM: `return_call` (proper tail call) from one exported, non-excluded
;; function directly into ANOTHER exported, non-excluded function, followed
;; by a third, unrelated exported call from the true top-level caller.
;;
;; script_gen's EC entry probe for a group of exported functions is:
;;   if (call_depth == 0) { <emit EC>; ... }
;;   call_depth = call_depth + 1;
;; and the ONLY decrement is `wasm:func:exit`. A `return_call` transfers
;; control away without executing $a's own `return`/fall-through-to-`end`,
;; so whatever code path whamm uses to fire `wasm:func:exit` for $a is never
;; reached — call_depth is left permanently +1 after this sequence.
;;
;; IMPORTANT COUNTERPOINT (read wizard-engine/src/monitors/R3Monitor.v3
;; before assuming this diverges): the oracle's own bookkeeping is NOT a
;; true hardware-call-stack depth. It is `call_kind_stack`, a software stack
;; of (CallKind, fid) pairs pushed by `onFuncEntry` (fired from a probe at
;; bytecode offset 0 of every non-excluded function — this DOES fire for
;; $b even though it was tail-called-into, since it's bound to a bytecode
;; position, not a call *site*) and popped only by `onFuncExit`, which the
;; oracle wires to `visit_RETURN` and to `visit_END` *only when
;; `bi.pc+1==bytecode.length`* (R3MonitorBytecodeInstrumenter, no
;; `visit_RETURN_CALL` override). A function that leaves solely via
;; `return_call` never reaches either of those points either, so the
;; oracle's own call_kind_stack ALSO leaks $a's frame and is ALSO stuck
;; showing a non-EXT top forever after.
;;
;; Because both trackers reduce to "is there at least one un-popped,
;; non-external entry outstanding" and a single tail call produces exactly
;; one permanent leak on both sides, our own static trace-through PREDICTED
;; this case does NOT diverge — both sides wrongly suppress the EC for $b
;; and for every export called afterwards ($c), matching the already-filed
;; gap "Tail calls (`return_call`) | Oracle semantics unclear" in
;; CLAUDE.md (which reports the identical "both look wrong" symptom for a
;; tail call into an EXCLUDED function).
;;
;; VERIFIED (1 of the 3 budgeted test_one.sh runs, 2026-09-21): FAIL, and
;; the prediction above was WRONG about direction:
;;   oracle: EC;1;a;
;;   ours:   EC;1;a;
;;           EC;2;b;
;;           EC;3;c;
;; The oracle drops $b's AND $c's EC forever (exactly the leaked
;; call_kind_stack behavior predicted from reading R3Monitor.v3's
;; ExitProbe wiring — it only overrides visit_RETURN/visit_END, no
;; visit_RETURN_CALL, so $a's frame is never popped). OUR side does NOT
;; drop them: apparently whamm's actual `wasm:func:exit` placement is more
;; robust across `return_call` than the R3Monitor.v3 source read alone
;; suggested (the exact whamm-internal reason wasn't traced further, given
;; the run budget, but the effect is clear and reproducible). So this shape
;; — tail call between two ordinary EXPORTED, non-excluded functions,
;; distinct from the filed gap's "tail call into an excluded function" — is
;; a genuinely new repro showing the *oracle* silently drops two real EC
;; events while our reimplementation gets it right. Worth folding into the
;; existing tailcall.wat gap file/question to Titzer as a second, broader
;; data point (previously that repro was scoped to calls into excluded
;; code only).
;;
;; Needs --enable-tail-call for wat2wasm. wizard-engine's default extension
;; set (Wasm 3.0, src/engine/Extension.v3 getDefaults()) includes TAIL_CALL,
;; so no engine flag should be required on the oracle side.
(module
  (memory (export "mem") 1)
  (global $n (mut i32) (i32.const 0))

  (func $r3_main (export "_start")
    call $a
    call $c)

  ;; $a: entered normally (EC expected, depth 0->1), then tail-calls away
  ;; without ever executing its own return/end.
  (func $a (export "a")
    global.get $n
    i32.const 1
    i32.add
    global.set $n
    return_call $b)

  ;; $b: entered only via the tail call above. Whether call_depth reads 0 or
  ;; 1 here is exactly the fact under test. (return_call requires $b's result
  ;; type to match $a's, i.e. none, so $b writes to the global instead of
  ;; returning a value.)
  (func $b (export "b")
    global.get $n
    i32.const 100
    i32.add
    global.set $n)

  ;; $c: an ordinary, unrelated export called by the true top-level caller
  ;; *after* $b has returned normally. If the leaked frame ever causes an
  ;; asymmetry between our flat counter and the oracle's stack, it must show
  ;; up here as a wrong EC decision for $c.
  (func $c (export "c")
    nop))
