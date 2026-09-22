;; report_recurse_ig_reorder: recursive report-anchor splits the trace across
;; multiple wasm:report flushes, so print_trace's per-batch IG hoist can no
;; longer match the oracle's instantiation-time, globally-sorted IG hoist.
;;
;; MECHANISM (traced through whamm + wizard-engine source, not guesswork):
;;   - whamm picks exactly ONE function to host the report/on_exit flush:
;;     the export named "main", else "_start", else the module's start fn
;;     (visiting_emitter.rs ~1360-1385: `main.func_exit(); main.call(on_exit_id)`).
;;     That single function gets `r3_mem.print_trace()` called at EVERY one of
;;     ITS OWN returns -- including nested/recursive returns, not just the
;;     single top-level call wizeng itself makes into it (WasmMode.v3
;;     `findMain` resolves "main"/"_start" the same way, and calls it once
;;     with zero-valued default args for any params).
;;   - Our `print_trace` (helper_lib/src/lib.rs) hoists IG events to the front,
;;     sorted by global index, but ONLY within the slice of events recorded
;;     since the last flush (`s.trace[unprinted..]`, the 'printed' cursor). It
;;     has no way to reorder anything an EARLIER flush already wrote to stdout.
;;   - The oracle (wizard-engine R3Monitor.v3 `onInstantiate`) unconditionally
;;     emits an ImportGlobal event for every imported global, in global-index
;;     order, at INSTANTIATION -- before the module has executed a single
;;     instruction -- and prints its entire trace exactly once, at `onFinish`
;;     (true program end). So in the oracle's output IG events are always
;;     first, in index order, regardless of when (or whether) the app ever
;;     reads them.
;;
;; This module makes "main" (the report anchor) recurse on itself via plain
;; `call`, passing the recursion depth as a PARAMETER (so each frame keeps its
;; own level even after nested calls mutate shared state). It reads two
;; DIFFERENT imported globals -- $b (index 1) from the middle frame, after the
;; innermost call has already returned and fired its own flush, and $a
;; (index 0) later still, from the outermost frame:
;;
;;   oracle order:  IG;0;<a>   IG;1;<b>   EC;<main>;
;;   our order:     EC;<main>;   IG;1;<b>   IG;0;<a>
;;
;; i.e. this single case demonstrates BOTH failure modes called out for this
;; lens: an IG event landing after non-IG events it should precede, AND two
;; IG events printed in the wrong relative (non-index-sorted) order, because
;; each was hoisted only within its own report batch.
;;
;; Needs a real (import-section) imported global, so this is a two-module
;; test run with test_ig.sh, not test_one.sh (host module: _host.wat/.wasm).
;;
;; VERIFIED (./test_ig.sh): FAIL, exactly as predicted. Oracle (after the
;; harness's standard IG-dedup, which is an unrelated, already-documented
;; multi-module quirk): `IG;0;111`, `IG;1;222`, `EC;0;main;0`. Ours:
;; `EC;0;main;0`, `IG;1;222`, `IG;0;111` -- both the EC-before-IG and the
;; reversed-index-order IG mismatches occur, in one run.
(module
  (import "report_recurse_ig_reorder_host" "a" (global $a (mut i32)))
  (import "report_recurse_ig_reorder_host" "b" (global $b (mut i32)))
  (func $main (export "main") (param $lvl i32)
    (if (i32.lt_s (local.get $lvl) (i32.const 2))
      (then
        (call $main (i32.add (local.get $lvl) (i32.const 1)))
        ;; Back in this frame after the recursive call (and its own report
        ;; flush) has already fired. $lvl is a LOCAL, so it still reflects
        ;; this frame's own depth, unlike a shared mutable global would.
        (if (i32.eq (local.get $lvl) (i32.const 1))
          (then (drop (global.get $b)))
          (else (drop (global.get $a))))
      )
    )
  )
)
