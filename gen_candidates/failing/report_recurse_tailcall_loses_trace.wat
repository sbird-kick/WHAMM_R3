;; report_recurse_tailcall_loses_trace: self-tail-recursive "main" -- VERIFIED
;; DIVERGENCE, actually run against the oracle (see below), and NOT the
;; failure mode originally hypothesized.
;;
;; whamm's own `is_prog_exit_call` (emitter/rewriting/rules/mod.rs) matches
;; both `Operator::Call` and `Operator::ReturnCall` identically wherever it
;; checks for a function "exiting" via a call, so it was a reasonable guess
;; that our `wasm:func:exit`-driven `call_depth` bookkeeping (used to gate EC
;; recording to true top-level entries: script_gen's
;; `if (call_depth == 0) { record EC; ... }`) might likewise treat a
;; `return_call` as an exit of the CALLING frame. Ran it (`./test_one.sh`)
;; instead of guessing further:
;;
;;   oracle: EC;0;main;                     (one entry, as expected)
;;   ours:   EC;0;main;  (x6, once per recursion level)
;;
;; FAIL, confirmed -- and the mechanism is exactly that guess: each
;; `return_call $main` is treated as an exit of the current "main" frame
;; (decrementing `call_depth` back toward 0) immediately before the callee's
;; own entry probe re-checks `call_depth == 0`, which is now true again, so
;; EVERY tail-recursive step spuriously re-triggers EC recording for "main".
;; This is a genuine whamm/script_gen interaction bug: `call_depth` is not
;; robust to the tail-call proposal, over-counting exits and producing N
;; spurious duplicate EC lines for an N-deep self-tail-recursive entry
;; function, instead of the single one the oracle (and non-tail recursion)
;; correctly produce. Separately, note this ALSO means `wasm:report` itself
;; fires (only once, at the very end) even though every intermediate frame
;; exits via `return_call` and never reaches the function's trailing `end`
;; -- so the report-anchor hook itself is not the affected mechanism here,
;; only script_gen's `call_depth` counter is.
;;
;; Each recursion level does an i32.store to a distinct address, which was
;; not needed to see the bug (no L events showed a divergence -- the L
;; probes are unaffected, only the EC/call_depth gating is) but is kept here
;; in case a load-side interaction shows up on a different whamm build.
;;
;; Needs the tail-call proposal: wat2wasm --enable-tail-call.
(module
  (memory 1)
  (global $depth (mut i32) (i32.const 5))
  (func $main (export "main")
    (i32.store
      (i32.mul (global.get $depth) (i32.const 4))
      (i32.add (global.get $depth) (i32.const 100)))
    (if (i32.gt_s (global.get $depth) (i32.const 0))
      (then
        (global.set $depth (i32.sub (global.get $depth) (i32.const 1)))
        (return_call $main))
    )
  )
)
