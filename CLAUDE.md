# WHAMM_R3 — Project State

Reimplementing Wizard Engine's R3 replay-recording monitor using whamm bytecode instrumentation. Two components: **script_gen** (Rust binary) parses a target .wasm and generates a tailored .mm whamm script; **r3_mem** (Rust → wasm32-wasip1) is a helper library for shadow memory/globals/tables and event recording. Verified against Wizard's built-in R3 monitor as oracle.

## Test status

**117/117 passing** via `./run_tests.sh` (103 wasm-r3 incl. 4 float-memory + 5 IG multi-module + 9 C/C++).

## Event coverage

| Event | Status | Notes |
|-------|--------|-------|
| EC (External Call) | Done | Per-function `opidx == 0` probes with call_depth state machine |
| IC (Import Call) | Done | Direct: `call:before`. Indirect: `call_indirect` → `func:entry` flag pattern |
| IR (Import Return) | Done | Direct: `call:after` grouped by return type. Indirect: `call_indirect:after` |
| L (Load) | Done | Shadow memory (`Vec<u8>`), seeded from data segments. Tracks i32/i64/f32/f64 loads & stores (all sub-word variants). v128/SIMD not tracked (whamm has no v128 type support) |
| G (Global Get) | Done | Shadow globals (`Vec<i64>`), tracks exported + imported mutable globals |
| IG (Import Global) | Done | One-shot `global.get:after` per imported global, reordered at print time |
| MG (Memory Grow) | Done | Uses `mem_size(APP_MEMID)` at EC/IR boundaries to detect any grow (whamm#300 resolved) |
| T (Table Get) | Blocked | Needs whamm#299 (funcref/GC type support for `table.get`/`table.set`) |
| TC (Table Call) | Blocked | Needs whamm#299 |
| TG (Table Grow) | Blocked | Needs whamm#299 |

## whamm feature request status

- **[whamm#299](https://github.com/ejrgilbert/whamm/issues/299)** — `argN`/`resN` for `table.get` and `table.set` (requires GC type support in whamm). Would unblock T/TC/TG events. **Deprioritized** per Ben Titzer (co-founder of wasm): table mutation events can't really be done via bytecode rewriting and are exceedingly rare in practice (only 5 occurrences across 4 files in our 117-test suite).
- **[whamm#300](https://github.com/ejrgilbert/whamm/issues/300)** — `mem_size(memid)` and `page_size(memid)` bound functions. **Resolved**, used for MG detection at EC/IR boundaries.
- **[whamm#301](https://github.com/ejrgilbert/whamm/issues/301)** — resolved fid from `call_indirect`. **Landed but unusable for us.** Tried switching from the 3-phase flag pattern to `if (resolved_fid == ...)` in `call_indirect:before`. Two problems:
  1. **Init-time only**: `resolved_fid` resolves the funcref using a static shadow table populated from the element segment. Any runtime `table.set` (or host table modification) makes the resolution stale, missing IC events.
  2. **Recursive call_indirect traps with `TABLE_OOB`**: When a probe references `resolved_fid` and the wasm code does recursive `call_indirect` (a function indirectly calls itself), the instrumented module traps inside whamm's shadow-table machinery. Reproduced minimally with a 1-entry static table and a self-recursive function. Standalone repro at `~/Downloads/claude-play-space/whamm_repro_resolved_fid_trap/`. Worth filing as a whamm bug.
  
  We kept the 3-phase pattern (`tracking_indirect` → `func:entry` → `call_indirect:after`) because `func:entry` sees the actual function being entered at runtime, regardless of how the table was populated.

## Key non-obvious decisions

**Read these before changing anything — they exist for specific reasons:**

- **`opidx == 0` instead of `func:entry` for EC detection.** `func:entry` and `call:before` are different event categories; whamm's insertion order puts IC before EC at the same position. `opcode:*:before` probes respect script order, so both EC and IC fire correctly.
- **Per-function entry probes** (one `opidx == 0 && fid == N` per export). Grouped probes with `fid == 1 || fid == 5` created multiple probes on the same event; whamm had a bug where >2 probes didn't respect script order. Per-function probes eliminate competition.
- **MG via `mem_size()` at boundaries, not `memory.grow:after`.** `check_mem_grow(mem_size(APP_MEMID))` is called at EC entry and after every IR. This detects memory growth regardless of whether it came from excluded wasm code or host API calls. `shadow_grow` (in `memory.grow:after` with exclude predicate) updates `shadow_pages` for non-excluded grows so they don't false-trigger MG. Lazy init: first `check_mem_grow` call sets the baseline without emitting MG (avoids false positives from whamm's own memory setup).
- **whamm bug: can't nest bound function calls inside user lib call arguments.** `r3_mem.check_mem_grow(mem_size(APP_MEMID))` crashes the verifier. Workaround: `var _cp: u32 = mem_size(APP_MEMID); r3_mem.check_mem_grow(_cp as i32);`
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
cd WHAMM_R3
cargo build --manifest-path script_gen/Cargo.toml
cargo build --manifest-path helper_lib/Cargo.toml --target wasm32-wasip1 --release
./run_tests.sh -j 32    # expects 117/117 PASS (uses wizeng.x86-64-linux --jit)
```

## User preferences

- Report suspected whamm bugs with minimal repros — don't work around them. Part of this project is testing whamm's robustness.
- Simplicity means logical simplicity, not line count.
- Always commit before making major changes.
