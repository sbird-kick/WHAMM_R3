---
name: project_r3_whamm
description: R3 monitor implementation in whamm — current state, known issues, and next steps
type: project
---

# R3 Whamm Monitor — Status as of 2026-03-24

## Goal
Implement wizard's R3 replay-recording monitor in whamm. Oracle is `wizeng --monitors="r3{...}"`.

## Repo Locations
- Monitor scripts: `WHAMM_R3/whamm_monitor/R3.mm` and `R3_r3exclude.mm`
- Helper lib: `WHAMM_R3/helper_lib/src/lib.rs`
- Comparison runner: `WHAMM_R3/compare_whamm_vs_wizard.sh`
- Whamm source: `../whamm/` (on `feature/bulk-mem-ops` branch)
- Wizard engine: `../wizard-engine/` (JVM backend)
- Virgil compiler: `../virgil/`

## Current Pass Rate (all event types: EC, IC, IR, L)
- **tc\* tests**: 0/25 — all fail with exactly 1 extra trailing EC (WASI runtime artifact, documented below)
- **tc\* tests (excluding trailing EC)**: 25/25 ✅
- **wasm-r3 tests**: 89/99
- **Total (excluding tc\* trailing EC)**: ~114/124 (92%)

## What Works
- **L (load) events**: 124/124 — shadow memory initialization from data segments via `active_data_start()`/`active_data_len()` on whamm's `feature/bulk-mem-ops` branch eliminated all 24 prior failures
- **EC (external call) events**: `call_depth` counter + `next_is_external` flag for re-entry detection
- **IC (import call) events**: `call:before` with `target_fn_name.starts_with(...)` — only fires from non-excluded functions (`&& !fname.starts_with(...)`)
- **IR (import return) events**: `call:after` with same predicates (bug #275 fixed upstream)
- **Event ordering**: `record_ec()` in helper lib swaps EC before a preceding IC when whamm insertion order places `call:before` code before `func:entry` code at the same position

## Shadow Memory Initialization
Uses whamm's `feature/bulk-mem-ops` branch built-ins:
```
var data_len: u32 = active_data_len(APP_MEMID);
var data_start: u32 = active_data_start(APP_MEMID);
var ptr: i32 = r3_mem.mem_alloc(data_len as i32);
memcpy(APP_MEMID, data_start, memid(r3_mem), ptr as u32, data_len);
```
Shadow is seeded on first `func:entry` via `r3_mem.init_shadow(ptr, data_start, data_len)`.
This replaced the old `has_had_ic` lazy-seeding approach entirely.

## Known Issues / Documented Limitations

### 1. Extra trailing EC in tc\* tests (not a bug — WASI runtime artifact)
Every tc\* test produces exactly 1 extra EC at the end of the trace. This comes from a WASI runtime function (e.g. `__wasm_call_ctors` or exit handler) that is not excluded by the `host_*` prefix filter. Wizard's native R3 monitor does not see this function. **Not worth fixing** — it's a WASI toolchain artifact, not an R3 logic error.

### 2. `call_indirect` not handled for IC/IR detection
The monitor only instruments `wasm:opcode:call:before/after` — it does not handle `call_indirect`. Tests involving table-based indirect calls to excluded functions will miss IC/IR events. Affected tests: `table-imp-host-mod`, `call-exp-after-import-call-table-get`.
**Deferred for later.**

### 3. IC/IR event ordering — solved via pending IC with caller context
When `call:before` and `func:entry` target the same code position (excluded call
is first instruction in a function), whamm inserts `call:before` code before
`func:entry` code, causing IC to fire before EC.

**Fix**: `record_ic(target_fid, caller_fid)` defers the IC as pending. When
`record_ec(fid)` fires, it checks whether `caller_fid == fid`:
- **Same function** (whamm artifact): emit EC first, then flush pending IC
- **Different function** (genuine order): flush pending IC first, then emit EC

Pending IC is also flushed before IR, L, and print_trace events.

### 4. EC re-entry detection edge cases (7 remaining wasm-r3 failures)
Some tests have extra or missing EC events from the `call_depth`/`next_is_external` re-entry logic:
- **Extra ECs**: `external-call` (+2), `mem-exp-host-mod-loadxx_x` (+5)
- **Missing ECs**: `call-exp-func-from-imp-func-param` (-1), `mem-exp-host-grow-no-return` (-1), `reentry` (-1), `mem-exp-host-mod-location-reentry` (-1, also IC ordering), `glob-exp-host-mod-multiple` (-1, also IC ordering)

### 6. `target_fn_type == "import"` does not work for wasm-r3 tests
wasm-r3 test modules have no actual wasm imports — "host" functions are local r3-prefixed stubs. The predicate `target_fn_type == "import"` never matches. IC/IR detection uses `target_fn_name.starts_with("r3")` instead.

## Architecture

### Monitor scripts
- `R3.mm` — for tc\* tests (exclude=host\_\*)
- `R3_r3exclude.mm` — for wasm-r3 tests (exclude=r3\*)

Both share the same structure:
1. Top-level: data segment init (`active_data_start`, `active_data_len`, `memcpy`)
2. `func:entry` / `func:exit`: EC detection + call\_depth tracking + one-time shadow init
3. `call:before` / `call:after`: IC/IR detection (only from non-excluded functions)
4. `store:before` / `load:after`: shadow memory tracking
5. `report`: trace output

### Helper lib (r3\_mem)
- `init_shadow(ptr, start_addr, len)`: seeds shadow from data segment copy
- `record_ec(fid)`: pushes EC (with IC swap fix)
- `record_ic(fid)`: pushes IC
- `record_ir(fid)`: pushes IR
- `shadow_store(addr, size, value)`: updates shadow on wasm stores
- `check_load(addr, size, value)`: compares shadow vs live, emits L on mismatch
- `print_trace()`: outputs all events in R3 format

## Dependencies
- **Virgil** (Aeneas III-11.1916, JAR backend) — required for wizard-engine
- **Wizard Engine** (26.2944, JVM target) — R3 oracle + wasm runtime
- **OpenJDK 21** — JVM for virgil/wizard
- **whamm** (`feature/bulk-mem-ops` branch) — instrumentation tool
- **Rust** (via rustup, with `wasm32-wasip1` target) — builds helper lib + whamm
