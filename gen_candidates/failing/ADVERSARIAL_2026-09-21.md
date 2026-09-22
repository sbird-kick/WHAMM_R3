# Adversarial campaign, 2026-09-21

Six agents (5 generating, 1 researching corpora) run against the R3 writer after the
`print_trace` cursor fix. 27 cases generated; the 8 below reproduce as FAIL and were each
re-verified independently of the generating agent. `gen_tests/gap_passive_cap_at_boundary`
is the passing control for the passive-cap pair and lives in the main suite.

**None of these is a regression from the `printed` cursor fix** — all 8 were re-run with the
cursor disabled and fail identically, so they are pre-existing.

## New (not previously documented)

### `lc_start_and_main_distinct` — report anchor vs. entry point disagreement
A module exporting `_start` and `main` as *distinct* functions loses its entire trace.
Oracle: `EC;0;_start;`. Ours: nothing at all.

Root cause (traced with `wasm-objdump -d`, and NOT what the generating agent concluded):
whamm emits an `on_exit` function that calls `print_trace`, and anchors the call to it
inside **one** designated function. It picks `main`. Wizard's CLI driver picks `_start` as
the entry. So `main` never runs, `on_exit` never runs, `print_trace` never fires, and a
fully and correctly recorded trace is silently discarded — `calls` monitor on the
instrumented module shows `begin_event: 1`, `end_event: 1`, `print_trace` absent.

Where whamm anchors `on_exit`:
| module exports | anchor | driver invokes | result |
|---|---|---|---|
| `_start` only (the shape of all 894 gen_tests) | `func <_start>` | `_start` | flushes, passes |
| `_start` + `main`, distinct funcs | `func <main>` | `_start` | never flushes |

This is the mirror of the bug fixed in `ced3c85`: there the report fired twice, here zero
times. The agent's stated cause (whamm injecting a start section changes wizard's entry
policy) is **wrong** — the passing module gets an injected start section too.

Possible defence, enabled by the cursor fix: now that `print_trace` is idempotent, we could
flush at more anchors without double-printing. Not attempted.

### `cf_proc_exit_mid_call` — proc_exit mid-call truncates the trace
Oracle `EC;1;_start;` + `IC;0`; ours drops events. `proc_exit` is not mentioned anywhere in
CLAUDE.md — wholly unexercised before now.

### `cf_tailcall_export_to_export` / `report_recurse_tailcall_loses_trace` — tail calls
`return_call` from one exported function to another leaves `call_depth` unbalanced: the
callee never fires `func:exit` against the caller's frame. Oracle emits `EC;1;a;` only;
ours emits a spurious second `EC`. The recursion variant loses the trace entirely.

### `report_recurse_ig_reorder` — IG hoisting across report batches (multi-module)
`print_trace` hoists IG events to the front of each batch, sorted by global index. When the
report anchor recurses, the batching splits IG events across batches and the per-batch sort
no longer reproduces the oracle's single global ordering.

## Known gaps, now with a reproducing test

- `gap_cross_memory_copy` — CLAUDE.md already records "cross-memory `memory.copy`
  unroutable (whamm exposes one memidx imm)". First actual test.
- `g05_multivalue_ir_res_ordering` — CLAUDE.md records multi-value IR as implementable but
  unimplemented ("no current test needs it"). One now does.
- `gap_passive_cap_over_boundary` — exercises past the documented 64KB passive-segment cap.
  `gen_tests/gap_passive_cap_at_boundary` is the at-boundary control and PASSES, so the pair
  brackets the cap precisely.

## Corpus research

Top recommendation: **`wasm-r3-bench`** — the 27 real-world replay modules from the
Wasm-R3 OOPSLA'24 paper, at https://github.com/doehyunbaek/wasm-benchmarks/tree/main/wasm-r3-bench.
The researching agent downloaded 4 and parsed the section layout of all 27: every module has
zero imports, a single memory, and exports `_start`/`main` bound to a function named
`r3 main` or `r3_main` — which is exactly the convention `test_one.sh` already keys on via
`--exclude "r3"`. Reported as a drop-in for the existing harness. NOT yet verified by us.

Also flagged must-borrow: `wasm-smith` (bytecodealliance/wasm-tools) for generated module
shapes, and Wizard's own vendored spec/proposal `.wast` corpus.
