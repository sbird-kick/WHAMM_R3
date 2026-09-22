;; LIFECYCLE/ENTRY-POINT ADVERSARIAL CASE
;;
;; Module exports BOTH "_start" and "main" as two DIFFERENT functions (not
;; aliases of one function, unlike the common house-style pattern seen in
;; gen_tests/bulk_*.wat where "_start" and "main" name the SAME function).
;; Neither is declared as the wasm `(start ...)` section.
;;
;; Mechanism under test: this isn't an instrumentation-logic question so much
;; as an ENTRY-SELECTION question that both sides must agree on to have any
;; chance of matching. Wizard's driver (used identically for the oracle run
;; and our instrumented run, per test_common.sh) has to decide which
;; export(s) to actually invoke when handed a module exporting two plausible
;; entry names. If it invokes only one of them (say "_start", WASI
;; convention) that's a wash — script_gen instruments both export fids
;; unconditionally (group_by_sig over ALL export fids), so whichever one
;; fires gets a correct, symmetric EC either way. But if Wizard's picker
;; invokes BOTH (e.g. runs "_start" then separately also runs "main" because
;; it doesn't disambiguate), we get two EC entries at call_depth==0 for two
;; DIFFERENT fids in a single run, each touching the same exported global —
;; exercising call_depth reset between two independent top-level invocations
;; and G-shadow consistency across them. Worth running empirically: which
;; export Wizard's harness actually calls is not documented anywhere we've
;; read, and picking wrong (invoking a different export than the oracle
;; expects, or invoking a different NUMBER of exports) silently produces a
;; missing/extra EC pair on one side only.
;;
;; RAN IT (test_one.sh): FAIL — confirmed, with root cause identified below.
;;   Oracle:  EC;0;_start;                (invokes ONLY "_start", once)
;;   Ours:    (nothing at all)
;; Manually replayed the harness's own steps to see why: `wasm-objdump -x` on
;; our whamm-instrumented binary shows whamm added its OWN `(start 33)`
;; section (the original module has no start section at all — neither
;; function is the wasm start). $WIZENG's CLI driver evidently changes its
;; entry-selection policy based on the mere PRESENCE of a start section: the
;; original binary (no start section) gets its "_start" export invoked by
;; convention, but the instrumented binary (now WITH a whamm-synthesized
;; start section, needed to run @init code) apparently no longer looks for
;; "_start"/"main" at all and just runs the start section, producing no
;; monitor output whatsoever. This is a real, confirmed divergence: **whamm's
;; act of instrumenting a module changes whether Wizard's CLI driver treats
;; it as having a callable entry point**, independent of anything in
;; script_gen's or r3_mem's logic — any exported-function-only module (no
;; wasm `(start ...)` section) that whamm instruments is at risk of losing
;; its entire trace this way. Worth a minimal whamm/wizeng repro report.
(module
  (global $g (export "g") (mut i32) (i32.const 10))
  (func $start_fn (export "_start")
    global.get $g
    i32.const 1
    i32.sub
    global.set $g)
  (func $main_fn (export "main")
    global.get $g
    i32.const 100
    i32.add
    global.set $g))
