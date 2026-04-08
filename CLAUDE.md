# WHAMM_R3 — Project State

Reimplementing Wizard Engine's R3 replay-recording monitor using whamm bytecode instrumentation. Two components: **script_gen** (Rust binary) parses a target .wasm and generates a tailored .mm whamm script; **r3_mem** (Rust → wasm32-wasip1) is a helper library for shadow memory/globals/tables and event recording. Verified against Wizard's built-in R3 monitor as oracle.

## Test status

**113/113 passing** via `./run_tests.sh` (99 wasm-r3 + 5 IG multi-module + 9 C/C++).

## Event coverage

| Event | Status | Notes |
|-------|--------|-------|
| EC (External Call) | Done | Per-function `opidx == 0` probes with call_depth state machine |
| IC (Import Call) | Done | Direct: `call:before`. Indirect: `call_indirect` → `func:entry` flag pattern |
| IR (Import Return) | Done | Direct: `call:after` grouped by return type. Indirect: `call_indirect:after` |
| L (Load) | Done | Shadow memory (`Vec<u8>`), seeded from data segments |
| G (Global Get) | Done | Shadow globals (`Vec<i64>`), tracks exported + imported mutable globals |
| IG (Import Global) | Done | One-shot `global.get:after` per imported global, reordered at print time |
| MG (Memory Grow) | Done | Uses `mem_size(APP_MEMID)` at EC/IR boundaries to detect any grow (whamm#300 resolved) |
| T (Table Get) | Blocked | Needs whamm#299 (funcref/GC type support for `table.get`/`table.set`) |
| TC (Table Call) | Blocked | Needs whamm#299 |
| TG (Table Grow) | Blocked | Needs whamm#299 |

## Blocked on whamm feature requests

- **[whamm#299](https://github.com/ejrgilbert/whamm/issues/299)** — `argN`/`resN` for `table.get` and `table.set` (requires GC type support in whamm). Unblocks T/TC/TG events. Implementation plan: shadow table (`Vec<Vec<i32>>`) with `shadow_table_set` on `table.set:before`, `check_table_get` on `table.get:after`. 4 tests currently silently pass because grep filter excludes `T;` — add T to filters once implemented.
- **[whamm#301](https://github.com/ejrgilbert/whamm/issues/301)** — resolved fid from `call_indirect` (also requires GC types). Would let us replace the 3-phase `tracking_indirect` / `func:entry` / `call_indirect:after` flag pattern with a direct predicate.

## Resolved whamm feature requests

- **[whamm#300](https://github.com/ejrgilbert/whamm/issues/300)** — `mem_size(memid)` and `page_size(memid)` bound functions. Now available in whamm master. Used for MG detection at EC/IR boundaries.

## Key non-obvious decisions

**Read these before changing anything — they exist for specific reasons:**

- **`opidx == 0` instead of `func:entry` for EC detection.** `func:entry` and `call:before` are different event categories; whamm's insertion order puts IC before EC at the same position. `opcode:*:before` probes respect script order, so both EC and IC fire correctly.
- **Per-function entry probes** (one `opidx == 0 && fid == N` per export). Grouped probes with `fid == 1 || fid == 5` created multiple probes on the same event; whamm had a bug where >2 probes didn't respect script order. Per-function probes eliminate competition.
- **MG via `mem_size()` at boundaries, not `memory.grow:after`.** `check_mem_grow(mem_size(APP_MEMID))` is called at EC entry and after every IR. This detects memory growth regardless of whether it came from excluded wasm code or host API calls. `shadow_grow` (in `memory.grow:after` with exclude predicate) updates `shadow_pages` for non-excluded grows so they don't false-trigger MG. Lazy init: first `check_mem_grow` call sets the baseline without emitting MG (avoids false positives from whamm's own memory setup).
- **whamm bug: can't nest bound function calls inside user lib call arguments.** `r3_mem.check_mem_grow(mem_size(APP_MEMID))` crashes the verifier. Workaround: `var _cp: u32 = mem_size(APP_MEMID); r3_mem.check_mem_grow(_cp as i32);`
- **`argN` stack ordering is reversed.** `arg0` = top of stack = last operand pushed. For `memory.fill(dest, val, len)`: `arg0`=len, `arg1`=val, `arg2`=dest.
- **`report var` fires exactly once** (at first probe activation). Used for one-time init like shadow memory seeding. `var` at script level runs at module init.
- **IG events reordered at print time.** Recorded lazily via `global.get:after` (one-shot guard), but printed first (sorted by index) in `print_trace` to match oracle.
- **Oracle IG duplication in multi-module.** Wizard's `onInstantiate` fires for every loaded module, duplicating IG events. `test_ig.sh` deduplicates with `awk '!seen[$0]++'`.

## Key files (read order)

1. `README.md` — full documentation (architecture, algorithms, setup, all design decisions)
2. `script_gen/src/main.rs` — code generator (~370 lines)
3. `helper_lib/src/lib.rs` — r3_mem runtime library (~280 lines)
4. `test_one.sh` / `test_c.sh` / `test_ig.sh` — per-suite test harnesses
5. `run_tests.sh` — combined runner (all 113 tests)

## Build & test

```bash
cd WHAMM_R3
cargo build --manifest-path script_gen/Cargo.toml
cargo build --manifest-path helper_lib/Cargo.toml --target wasm32-wasip1 --release
export VIRGIL_LOC=../virgil
./run_tests.sh    # expects 113/113 PASS
```

Whamm must be built from latest master (needs `mem_size`/`page_size` support):
```bash
cd ../whamm && git pull origin master && cargo build
cargo build --target wasm32-wasip1 --release -p whamm_core
```

## User preferences

- Report suspected whamm bugs with minimal repros — don't work around them. Part of this project is testing whamm's robustness.
- Simplicity means logical simplicity, not line count.
- Always commit before making major changes.
