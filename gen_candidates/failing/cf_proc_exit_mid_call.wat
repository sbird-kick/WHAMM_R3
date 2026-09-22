;; LENS: control-flow that breaks call_depth bookkeeping (E: unwinding).
;;
;; MECHANISM: WASI proc_exit called deep inside a nested call chain.
;;
;; Per wizard-engine/src/modules/wasi/WspOneModule.v3:317-319, proc_exit is
;; implemented as `HostResult.Throw(Exit.new(code))` — a Virgil-level
;; Throwable that unwinds the *entire* interpreter's native call stack, not
;; a wasm-level trap and not something a wasm `try_table` can intercept (the
;; unwind happens above the wasm abstraction, exactly like a host-fatal
;; error). It propagates straight through _start, outer and inner without
;; any of their own code executing again.
;;
;; Oracle (Wizard's native R3Monitor): its `onFinish(instance, result)` is a
;; monitor-lifecycle hook invoked by the engine's CLI driver after every run,
;; success/trap/host-exit alike (R3Monitor.v3:37-41). It unconditionally
;; renders whatever trace.put() calls have already happened. The R3CallProbe
;; for `call $proc_exit` (visit_CALL, unconditional — see
;; R3MonitorBytecodeInstrumenter.checkCallReturnAndInsertProbe) fires and
;; records IC *before* the call executes, so IC survives even though the
;; call never "returns" (the trailing ReturnProbe for it never fires, so no
;; IR — correct, since proc_exit truly doesn't return). Net oracle trace:
;;   EC;<outer's fid>;outer;
;;   IC;<proc_exit's fid>;
;;
;; Ours: the equivalent IC is likewise recorded synchronously by
;; r3_mem.record_ic() the instant `call $proc_exit` executes (before the
;; real WASI call runs) — so that event IS captured in r3_mem's internal
;; Vec<TraceEvent>. BUT unlike the oracle, we have no engine-level "flush on
;; any termination" hook: r3_mem.print_trace() only runs because whamm
;; injects a call to it (the `on_exit` thunk) into ONE specific function.
;; Traced this precisely in ../whamm/src/emitter/rewriting/visiting_emitter.rs
;; (~line 1360): whamm picks `fid` = the export named "main", else "_start",
;; else the module's start function — and wires the flush ONLY into THAT
;; function's own `func_exit()` exit points via `main.func_exit();
;; main.call(on_exit_id);`. whamm *does* know about WASI's proc_exit
;; specifically — `is_prog_exit_call()` in rules/mod.rs hard-codes
;; `"wasi_snapshot_preview1:proc_exit"` in an `exiting_call` set precisely so
;; a direct call/return_call to it counts as an exit point worth flushing
;; before. But that awareness only fires while walking the designated
;; entry function's *own* bytecode — it is never applied recursively to
;; callees. Our proc_exit call sits inside $inner, three frames below
;; $_start, so it is invisible to this analysis: $_start's only exit point
;; is its own implicit trailing `end` (reached only if `call $outer`
;; returns normally, which it never does here), so no flush is ever wired
;; up and print_trace() is never called.
;;
;; VERIFIED (1 of the 3 budgeted test_c.sh runs, 2026-09-21): FAIL.
;;   oracle: EC;1;_start;
;;           IC;0
;;   ours:   EC;1;_start;
;; Confirmed by hand too (test_common.sh + manual whamm instr + both wizeng
;; invocations) so this is not a harness fluke. The divergence is real and
;; reproducible, exactly as predicted in direction (ours is missing content
;; the oracle has) though not quite in the shape first guessed above: the
;; EC recorded is for `_start` itself (fid 1, the true depth-0 entry), not
;; `outer` — and OUR side prints even that one EC before losing the IC that
;; comes later, meaning whatever triggers our one successful
;; wasm:report flush fires very early (right around `_start`'s own entry),
;; not only at a true end-of-function exit as first assumed. The generated
;; .mm and injected bytecode were inspected (saved reasoning below) but the
;; exact whamm-internal reason for that specific split print is not fully
;; pinned down — what IS pinned down, empirically, is that a real content
;; divergence exists for a WASI proc_exit call buried below the designated
;; entry function, which is the shape CLAUDE.md's wasm:report limitation
;; (c) has never been checked against (only a bare in-module `unreachable`
;; was verified there).
;;
;; Run with test_c.sh (real import => --exclude-imports convention); no
;; special wat2wasm proposal flag needed.
(module
  (import "wasi_snapshot_preview1" "proc_exit" (func $proc_exit (param i32)))
  (memory (export "memory") 1)

  (func $_start (export "_start")
    call $outer)

  (func $outer (export "outer")
    call $inner)

  (func $inner (export "inner")
    i32.const 7
    call $proc_exit))
