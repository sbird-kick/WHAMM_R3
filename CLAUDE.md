# WHAMM_R3 — Project State

Reimplementing Wizard Engine's R3 replay-recording monitor using whamm bytecode instrumentation. Two components: **script_gen** (Rust binary) parses a target .wasm and generates a tailored .mm whamm script; **r3_mem** (Rust → wasm32-wasip1) is a helper library for shadow memory/globals/tables and event recording. Verified against Wizard's built-in R3 monitor as oracle.

## Test status

**119/119 passing** via `./run_tests.sh` (103 wasm-r3 incl. 4 float-memory + 2 gen_tests + 5 IG multi-module + 9 C/C++). `gen_tests/` holds our own generated/regression tests (committed .wat + .wasm; rebuild: `wat2wasm --debug-names [--enable-multi-memory] x.wat -o x.wasm`).

Last verified **2026-07-23** on macOS arm64 (JVM backend) with: whamm master **v1.0.0** (`c461d20`), virgil `81f99693e`, wizard-engine `2ccc7300`. whamm previously lived on the `memory_bound_variables` branch — that's merged; use master now.

## Event coverage

| Event | Status | Notes |
|-------|--------|-------|
| EC (External Call) | Done | Per-function `opidx == 0` probes with call_depth state machine |
| IC (Import Call) | Done | Direct: `call:before`. Indirect: `call_indirect` → `func:entry` flag pattern |
| IR (Import Return) | Done | Direct: `call:after` grouped by return type. Indirect: `call_indirect:after` |
| L (Load) | Done | Per-memory shadows (`Vec<Vec<u8>>`), seeded from data segments; L prints real memidx. Tracks i32/i64/f32/f64 loads & stores (all sub-word variants), memory.fill/copy/grow, and memory.init from passive segments (registered at @init, 64KB cap). v128/SIMD not tracked (whamm has no v128 type support); cross-memory memory.copy unroutable (whamm exposes one memidx imm) |
| G (Global Get) | Done | Shadow globals (`Vec<i64>`), tracks exported + imported mutable globals |
| IG (Import Global) | Done | One-shot `global.get:after` per imported global, reordered at print time |
| MG (Memory Grow) | Done | Uses `mem_size(APP_MEMID)` at EC/IR boundaries to detect any grow (whamm#300 resolved). Per-memory page tracking; boundary checks cover memory 0 only — host-side grows of memory != 0 are undetectable |
| T (Table Get) | Blocked | Needs whamm#299 (funcref/GC type support for `table.get`/`table.set`) |
| TC (Table Call) | Blocked | Needs whamm#299 |
| TG (Table Grow) | Blocked | Needs whamm#299 |

## Gap audit (2026-07-23)

Systematic probe of every suspected coverage gap, oracle vs ours. Probe sources in `gen_tests/` (fixed ones) and the repro dirs (reported ones):

| Gap | Verdict | Status |
|-----|---------|--------|
| memory.init from passive segments | Our gap | **Fixed** — passive bytes registered @init, `memory.init:before` probe updates shadow. Regression: `gen_tests/gap_meminit` |
| Multi-memory L/MG | Our gap | **Fixed** — per-memory shadows via whamm's static `memory` bound var. Regression: `gen_tests/gap_multimem`. Limits: cross-memory `memory.copy` unroutable; MG boundary checks memory-0-only |
| Multi-value IR (2+ results) | whamm bug | Probe with `(res0, res1)` bounds on `call:after` silently never fires. Repro: `../whamm_repro_multivalue_resn/` — **report upstream** |
| Trace lost on trap | whamm feature gap | `wasm:report` output isn't flushed when app traps; Wizard's R3 prints its trace on trap. Repro: `../whamm_repro_report_on_trap/` — **request upstream** |
| IG for never-read imported globals | whamm feature gap | Oracle records IG for all imported globals at instantiation; we can only observe `global.get` executions. Needs a whamm primitive to read an app global at init. Probe: scratchpad `gap_ig_unread` |
| start functions | Wizard oracle bug | Oracle crashes: `R3MonitorError: external call with table_get failed` at `onFuncEntry`. Skip category (like complex/fibonacci) — worth reporting to Titzer |
| Tail calls (`return_call`) | Oracle semantics unclear | Oracle emits no IC for a tail call into an excluded fn and no EC for the next export call; both look wrong. Skip category; ask Titzer what R3 semantics should be |

## whamm feature request status

- **[whamm#299](https://github.com/ejrgilbert/whamm/issues/299)** — `argN`/`resN` for `table.get` and `table.set` (requires GC type support in whamm). Would unblock T/TC/TG events. **Closed 2026-04-27 without implementation** (maintainer: needs funcref type support whamm doesn't have; can reopen via Slack if needed). Also **deprioritized** per Ben Titzer (co-founder of wasm): table mutation events can't really be done via bytecode rewriting and are exceedingly rare in practice (only 5 occurrences across 4 files in our 117-test suite).
- **[whamm#300](https://github.com/ejrgilbert/whamm/issues/300)** — `mem_size(memid)` and `page_size(memid)` bound functions. **Resolved**, used for MG detection at EC/IR boundaries.
- **[whamm#301](https://github.com/ejrgilbert/whamm/issues/301)** — resolved fid from `call_indirect`. **Landed but unusable for us.** Tried switching from the 3-phase flag pattern to `if (resolved_fid == ...)` in `call_indirect:before`. Two problems:
  1. **Init-time only**: `resolved_fid` resolves the funcref using a static shadow table populated from the element segment. Any runtime `table.set` (or host table modification) makes the resolution stale, missing IC events.
  2. **Recursive call_indirect trapped with `TABLE_OOB`** — filed as [whamm#314](https://github.com/ejrgilbert/whamm/issues/314), **fixed upstream** (`6628c2d`, in v1.0.0) with regression test `call_indirect/recursive.wast`. Standalone repro at `~/Downloads/claude-play-space/whamm_repro_resolved_fid_trap/`.
  
  Reason 1 still stands even with the bug fixed, so we keep the 3-phase pattern (`tracking_indirect` → `func:entry` → `call_indirect:after`): `func:entry` sees the actual function being entered at runtime, regardless of how the table was populated.

## Key non-obvious decisions

**Read these before changing anything — they exist for specific reasons:**

- **`opidx == 0` instead of `func:entry` for EC detection.** `func:entry` and `call:before` are different event categories; whamm's insertion order puts IC before EC at the same position. `opcode:*:before` probes respect script order, so both EC and IC fire correctly.
- **EC entry probes grouped by param signature** (`opidx == 0 && (fid == A || fid == B)`). Were per-function until 2026-07-23: whamm <1.0 didn't respect script order with >2 probes on one event; retested on v1.0.0, fixed. If EC/IC ordering regresses, suspect this first.
- **MG via `mem_size()` at boundaries, not `memory.grow:after`.** `check_mem_grow(mem_size(APP_MEMID))` is called at EC entry and after every IR. This detects memory growth regardless of whether it came from excluded wasm code or host API calls. `shadow_grow` (in `memory.grow:after` with exclude predicate) updates `shadow_pages` for non-excluded grows so they don't false-trigger MG. Lazy init: first `check_mem_grow` call sets the baseline without emitting MG (avoids false positives from whamm's own memory setup).
- **Nested bound calls in user lib args** (`r3_mem.check_mem_grow(mem_size(APP_MEMID) as i32)`) crashed whamm's verifier before v1.0.0; fixed upstream, `_cp` temp-var workaround removed 2026-07-23.
- **`argN` stack ordering is reversed.** `arg0` = top of stack = last operand pushed. For `memory.fill(dest, val, len)`: `arg0`=len, `arg1`=val, `arg2`=dest.
- **`@init` annotation** runs library calls at initialization time. Used for shadow memory seeding (`init_shadow`) and name registration (`register_name`). Replaces the old `report var _x = lib.fn()` hack.
- **IG events reordered at print time.** Recorded lazily via `global.get:after` (one-shot guard), but printed first (sorted by index) in `print_trace` to match oracle.
- **Oracle IG duplication in multi-module.** Wizard's `onInstantiate` fires for every loaded module, duplicating IG events. `test_ig.sh` deduplicates with `awk '!seen[$0]++'`.
- **Float memory probes use dedicated `shadow_store_f32`/`shadow_store_f64`/`check_load_f32`/`check_load_f64`.** `arg0 as i64` / `res0 as i64` in whamm probe bodies does **numeric float-to-int conversion** (3.14 → 3), NOT bit reinterpretation. The float-specific r3_mem functions take `f32`/`f64` directly and use Rust's `.to_bits()` for proper IEEE 754 bit reinterpretation. The 4 float tests (`float-load-only`, `float-store-shadow`, `float-mixed`, `float-no-change`) plus `data_segments` (C/C++ with floats) verify both missing-L-event and false-L-event cases.

## Key files (read order)

1. `README.md` — full documentation (architecture, algorithms, setup, all design decisions)
2. `script_gen/src/main.rs` — code generator (~372 lines)
3. `helper_lib/src/lib.rs` — r3_mem runtime library (~299 lines)
4. `test_common.sh` — shared paths for all test harnesses
5. `test_one.sh` / `test_c.sh` / `test_ig.sh` — per-suite test harnesses
6. `run_tests.sh` — combined runner (all 117 tests)

## Build & test

```bash
# Rebuild deps after updating their repos:
cd whamm && cargo build && cargo build --target wasm32-wasip1 --release -p whamm_core
cd wizard-engine && PATH="$PWD/../virgil/bin:$PATH" ./build.sh wizeng jvm   # macOS oracle (needs OpenJDK); Linux: make x86-64-linux

cd WHAMM_R3
cargo build --manifest-path script_gen/Cargo.toml
cargo build --manifest-path helper_lib/Cargo.toml --target wasm32-wasip1 --release
./run_tests.sh -j 6    # expects 117/117 PASS. Max 6 jobs on this 8-core laptop — leave 2 cores free (user preference)
# test_common.sh auto-picks wizeng.jvm on macOS / wizeng.x86-64-linux --jit on Linux; override with WIZENG env var.
```

## User preferences

- Report suspected whamm bugs with minimal repros — don't work around them. Part of this project is testing whamm's robustness.
- Simplicity means logical simplicity, not line count.
- Always commit before making major changes.
