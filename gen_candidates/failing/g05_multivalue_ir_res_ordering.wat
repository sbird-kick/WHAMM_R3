;; VERIFIED via ./test_one.sh: FAIL (confirmed, not just predicted).
;; Oracle:  EC;2;_start; / IC;0 / IR;0;11,22 / IC;1 / IR;1;33
;; Ours:    EC;2;_start; / IC;0 / IC;1 / IR;1;33          <-- IR;0 missing entirely
;; So the failure mode is NOT "wrong value" as originally hypothesized below --
;; it's a SILENT DROP of the whole multi-value IR event, and (surprisingly)
;; it's the *second-declared* probe group (arity 2, for $r3_pair/fid 0) that
;; goes silent, while the *first-declared* group (arity 1, for $r3_single/
;; fid 1) fires fine. That's the OPPOSITE polarity from the cataloged/fixed
;; v1.0.0 typed-probe bug ("only the FIRST probe's local declaration gates the
;; drop"), so this looks like a DISTINCT whamm bug: two `call(resN...):after`
;; probes differing in ARITY (1 bound var vs 2), not just differing in a
;; single value's type, on the same opcode -- worth a fresh minimal repro
;; before filing, since it doesn't match the already-reported/fixed shape.
;;
;; Build note: wat2wasm does NOT emit a name section by default, so the
;; "r3_"-prefixed-name exclusion trick (below) silently does nothing unless
;; you pass --debug-names -- without it, script_gen sees excluded=[] and this
;; whole test is vacuous (both calls become ordinary uninstrumented calls,
;; no IC/IR at all). Discovered the hard way while building this batch:
;; `wat2wasm --debug-names g05_multivalue_ir_res_ordering.wat -o ....wasm`.
;;
;; TARGETS: emit_direct_call_probes / group_by_results / ty_bounds's handling
;; of a MULTI-VALUE (2+ results) excluded/"imported" function -- an explicitly
;; documented, currently-UNIMPLEMENTED gap per CLAUDE.md's gap table entry
;; "Multi-value IR (2+ results)": "resN is stack-ordered like argN: res0 = top
;; = LAST result, so `$f (result i32 i64)` needs `(res0: i64, res1: i32)`...
;; Implementable in script_gen whenever a multi-value import shows up (no
;; current test needs it)." That note is proof this exact shape has NEVER
;; been exercised: no test in the whole suite currently has an excluded or
;; imported function with 2+ results.
;;
;; Uses this project's "fake import" convention: a function is simulated as
;; an external/host boundary purely by naming it with the excluded prefix
;; ("r3_..."), no real wasm import section needed (see gen_tests/glob_11_*,
;; h4_recurse_glob_148 for the same trick) -- so this stays a single, plain
;; module runnable directly through test_one.sh.
;;
;; MECHANISM: `$r3_pair` has signature `(result i32 i64)`. script_gen's
;; `ty_bounds("res", results)` walks `results` (the wasm-declared type vector,
;; i.e. [i32, i64]) in DECLARATION order and emits `res0: i32, res1: i64` --
;; but at actual runtime the value on the TOP of the stack after the call
;; (which whamm binds to `res0`) is the LAST declared result, i.e. the i64.
;; So the generated probe's own bound-var type for `res0` (i32) does not match
;; the actual i64 value whamm would bind there. Two possible concrete
;; failures: (a) whamm's typecheck rejects the mismatched declared/actual
;; type and `whamm instr` fails outright for this module (test_one.sh reports
;; "FAIL (instr)"), or (b) whamm passes the raw stack value through under the
;; wrongly-declared type (numeric reinterpretation / truncation), producing
;; an IR event with corrupted/swapped param values -- e.g. printing the i64's
;; low 32 bits where an i32 was expected, or misordering the two fields
;; relative to the oracle's IR;1;<i64>;<i32> (which follows the SAME
;; stack/res0=last-result convention engine-side). Either way this predicts a
;; concrete divergence from the oracle, not a vague "might stress" claim.
;;
;; `$r3_single` (result i32) is included alongside `$r3_pair` purely so
;; group_by_results produces TWO separate `call(resN...):after` probe groups
;; on the same event category, checking whether the multi-value group's
;; malformed bound-var types also corrupt or suppress the sibling
;; single-value group's probe (the cross-group-interference shape of the
;; already-fixed-upstream v1.0.0 typed-probe bug, but for `call` instead of
;; `global.set`).
;;
;; No proposal flags needed.
(module
  (memory (export "mem") 1)
  (func $r3_pair (result i32 i64)
    i32.const 11
    i64.const 22)
  (func $r3_single (result i32)
    i32.const 33)
  (func (export "_start")
    call $r3_pair
    drop
    drop
    call $r3_single
    drop))
