# WHAMM R3 Monitor

Reimplementation of Wizard Engine's R3 replay-recording monitor using whamm bytecode instrumentation. The oracle is `wizeng --monitors="r3{exclude=...}"`.

## Current Status (2026-03-31)

**93/99 tests pass** (exact match on L, EC, IC, IR events against wizard oracle).

6 remaining failures — see "Known Failures" below.

## Architecture

```
WHAMM_R3/
├── script_gen/          # Rust binary: parses .wasm, generates .mm scripts
│   └── src/main.rs
├── helper_lib/          # Rust wasm lib (r3_mem): shadow memory + event recording
│   └── src/lib.rs
├── whamm_monitor/       # Old hand-written .mm scripts (kept as reference, not used)
├── tests/               # tc* test sources (Rust, compiled to wasm32-wasip1)
├── wasm_r3_tests/       # 99 wasm-r3 test binaries (from wizard test suite)
├── test_one.sh          # Per-test harness: gen → instrument → run → diff
├── compare_whamm_vs_wizard.sh  # Old comparison script (superseded by test_one.sh)
└── whamm_r3_project.md  # Historical project doc (partially outdated)
```

### Pipeline

```
                 script_gen                    whamm instr                    wizeng
input.wasm ──────────────────► generated.mm ─────────────────► instrumented.wasm ──────► trace output
                                    │                               │
                              uses r3_mem lib                  runs with whamm_core
                              (shadow memory,                  + r3_mem.wasm
                               event recording)
```

1. **script_gen** parses the target `.wasm` binary (type section, import section, function section, export section, name section) and generates a tailored `.mm` whamm script with:
   - Per-function entry probes (EC detection + call_depth tracking)
   - IC/IR probes for calls to excluded functions
   - Shadow memory store/load tracking (L events)
   - Export name registration via `write_str`
   - Data segment initialization via `active_data_start`/`active_data_len`

2. **whamm** instruments the target wasm with the generated script, linking in `whamm_core.wasm` and `r3_mem.wasm`.

3. **wizeng** runs the instrumented wasm. r3_mem records events in a trace buffer, then `print_trace()` outputs them in R3 format.

### Dependencies (all in ../relative to WHAMM_R3)

| Dependency | Location | Notes |
|------------|----------|-------|
| whamm | `../whamm/` | On `master` branch. Binary at `target/debug/whamm` |
| whamm_core | `../whamm/target/wasm32-wasip1/release/whamm_core.wasm` | Built with `cargo build --target wasm32-wasip1 --release -p whamm_core` |
| wizard-engine | `../wizard-engine/` | JVM backend: `bin/wizeng.jvm` |
| virgil | `../virgil/` | Required by wizard. Set `VIRGIL_LOC=../virgil` |
| OpenJDK | System | Required by wizard's JVM backend |
| Rust | System | With `wasm32-wasip1` target (`rustup target add wasm32-wasip1`) |
| wat2wasm | System | From wabt (`brew install wabt`) |
| wasm-tools | System | `cargo install wasm-tools` |

### System-wide symlinks (optional)

```bash
sudo ln -s /path/to/whamm/target/debug/whamm /usr/local/bin/whamm
sudo ln -s /path/to/whamm/target/wasm32-wasip1/release/whamm_core.wasm /usr/local/lib/whamm_core.wasm
sudo ln -s /path/to/wizard-engine/bin/wizeng.jvm /usr/local/bin/wizeng
```

These update automatically on rebuild since they're symlinks.

## Running Tests

### Single test
```bash
cd WHAMM_R3
export VIRGIL_LOC=../virgil
./test_one.sh wasm_r3_tests/exported-called-param.wasm
```

### Full suite (parallel, 8 cores)
```bash
export VIRGIL_LOC=../virgil
ls wasm_r3_tests/*.wasm | grep -v '\.index\.wasm$' | \
    xargs -P 8 -I{} ./test_one.sh {} | sort > /tmp/results.txt
grep -c '^PASS' /tmp/results.txt  # exact matches
grep -v '^PASS' /tmp/results.txt  # failures
```

### Manual single-test debugging
```bash
# 1. Generate .mm
script_gen/target/debug/script_gen wasm_r3_tests/FOO.wasm --exclude "r3" > /tmp/gen.mm

# 2. Instrument
whamm instr --script /tmp/gen.mm --app wasm_r3_tests/FOO.wasm \
    --core-lib ../whamm/target/wasm32-wasip1/release/whamm_core.wasm \
    --user-libs "r3_mem=helper_lib/target/wasm32-wasip1/release/r3_mem.wasm" \
    --output-path /tmp/instr.wasm

# 3. Compare
VIRGIL_LOC=../virgil ../wizard-engine/bin/wizeng.jvm --monitors="r3{exclude=r3*}" wasm_r3_tests/FOO.wasm
VIRGIL_LOC=../virgil ../wizard-engine/bin/wizeng.jvm ../whamm/target/wasm32-wasip1/release/whamm_core.wasm helper_lib/target/wasm32-wasip1/release/r3_mem.wasm /tmp/instr.wasm
```

### Building

```bash
# Helper lib (r3_mem)
cd helper_lib && cargo build --target wasm32-wasip1 --release

# Script generator
cd script_gen && cargo build

# whamm (if needed)
cd ../whamm && cargo build && cargo build --target wasm32-wasip1 --release -p whamm_core
```

## R3 Event Types

| Event | Format | Meaning |
|-------|--------|---------|
| EC | `EC;{fid};{export_name};{params}` | Host called an exported wasm function |
| IC | `IC;{fid}` | Wasm called an excluded (host) function |
| IR | `IR;{fid};{results}` | Excluded function returned to wasm |
| L | `L;0;{addr};{bytes}` | Load detected host-modified memory |

Param/result rendering: i32/i64 as signed decimal, f32/f64 as `0x{hex_bits}`.

## How Each Event Is Detected

### L (Load) Events — Shadow Memory

Every non-excluded wasm store updates a shadow `Vec<u8>` in r3_mem. Every non-excluded load compares the loaded value against the shadow. A mismatch means the host modified memory between the store and load — emit L event.

Shadow is initialized from the module's data segments at startup using whamm's `active_data_start(APP_MEMID)` / `active_data_len(APP_MEMID)` built-ins, which copy the data segment bytes into r3_mem's memory via `memcpy`. This is done once via `report var _shadow: i32 = r3_mem.init_shadow(...)`.

### EC (External Call) Events

script_gen generates one `wasm:opcode:*:before / opidx == 0 && fid == N /` probe per non-excluded exported function. This fires at the function's first instruction. The probe checks `call_depth == 0` — if true, the function was entered from the host (EC), not from wasm code.

For functions with parameters, the probe uses `localN` type bounds to access argument values:
```mm
wasm(local0: i32, local1: i32):opcode:*:before / opidx == 0 && fid == 5 / {
    if (call_depth == 0) {
        r3_mem.begin_ec(fid as i32);
        r3_mem.ec_param_i32(local0);
        r3_mem.ec_param_i32(local1);
        r3_mem.end_ec();
    }
    call_depth = call_depth + 1;
}
```

Export names are registered at script init time using whamm's `write_str` + `r3_mem.register_name(fid, ptr, len)`. The `report var` trick ensures each registration fires exactly once.

### IC (Import Call) Events

`wasm:opcode:call:before` where `imm0` (call target) is an excluded function and `fid` (caller) is not excluded. After recording, `call_depth` is decremented (we're leaving wasm, entering "host" code).

### IR (Import Return) Events

`wasm:opcode:call:after` with `resN` type bounds for the excluded function's return type. script_gen groups excluded functions by return signature and generates one probe per group. After recording, `call_depth` is incremented (returning from "host" to wasm).

### call_depth Tracking

A global `var call_depth: i32` tracks how deep we are in non-excluded wasm code:
- **Incremented** at `opidx == 0` of every non-excluded function (in the same probe as EC check)
- **Decremented** at `func:exit` of every non-excluded function
- **Decremented** at IC (entering excluded/host code)
- **Incremented** at IR (returning from excluded/host code)

EC fires only when `call_depth == 0` — meaning we entered from outside wasm (the host).

### Why `opcode:*:before / opidx == 0 /` Instead of `func:entry`

The `opidx == 0` hack is used because whamm inserts `func:entry` instrumentation at a different priority than `opcode:call:before` instrumentation. When a function's first instruction is a call to an excluded function, both EC and IC fire at the same bytecode position. With `func:entry` for EC and `call:before` for IC, whamm's insertion ordering puts IC before EC — wrong.

Using `opcode:*:before / opidx == 0 /` for EC puts both EC and IC in the same event category (opcode probes), where script order controls firing order.

### Why Per-Function Probes Instead of Grouped

Originally we grouped exports by signature (one probe per unique param list). But whamm has an ordering bug where >2 probes on `opcode:*:before` at the same location don't respect script order. Per-function probes ensure each function has exactly one `opidx == 0` probe, avoiding the issue.

## helper_lib (r3_mem) API

All functions are `#[no_mangle] pub extern` for wasm export.

### Memory
| Function | Signature | Notes |
|----------|-----------|-------|
| `mem_alloc` | `(len: i32) -> i32` | Allocates `len` bytes, returns pointer |
| `mem_free` | `(ptr: i32)` | Frees allocation from `mem_alloc` |

### Shadow Memory
| Function | Signature | Notes |
|----------|-----------|-------|
| `init_shadow` | `(data_ptr: i32, start_addr: i32, len: i32) -> i32` | Seeds shadow from data segment copy. Returns 0 (for `report var` trick). |
| `shadow_store` | `(addr: i32, size: i32, value: i64)` | Updates shadow on wasm store |
| `check_load` | `(addr: i32, size: i32, value: i64)` | Compares shadow vs live value, emits L on mismatch |

### Name Table
| Function | Signature | Notes |
|----------|-----------|-------|
| `register_name` | `(fid: i32, ptr: i32, len: i32) -> i32` | Reads string from own memory at `ptr`, stores in `name_table[fid]`. Returns 0. |

### EC Builder
| Function | Signature |
|----------|-----------|
| `begin_ec` | `(fid: i32)` |
| `ec_param_i32` | `(value: i32)` |
| `ec_param_i64` | `(value: i64)` |
| `ec_param_f32` | `(value: f32)` |
| `ec_param_f64` | `(value: f64)` |
| `end_ec` | `()` |

### IC
| Function | Signature |
|----------|-----------|
| `record_ic` | `(fid: i32)` |

### IR Builder
| Function | Signature |
|----------|-----------|
| `begin_ir` | `(fid: i32)` |
| `ir_result_i32` | `(value: i32)` |
| `ir_result_i64` | `(value: i64)` |
| `ir_result_f32` | `(value: f32)` |
| `ir_result_f64` | `(value: f64)` |
| `end_ir` | `()` |

### Output
| Function | Signature |
|----------|-----------|
| `print_trace` | `()` |

## script_gen Internals

### Wasm Parsing

Uses `wasmparser` 0.240.0 to extract:
- **Type section**: function signatures (params + results) per type index
- **Import section**: count of imported functions + their type indices
- **Function section**: type indices for local functions
- **Export section**: exported function names + global function indices
- **Name section**: debug names for function-ID-to-name mapping

### Exclusion Pattern

`--exclude "r3*"` matches functions whose **debug name** (from name section) starts with `"r3"`. This is how wasm-r3 test modules mark "host" functions. For real-world wasm, imports would be the host functions (no exclude pattern needed — just check `is_import`).

### Generated Script Structure

The script is emitted in this order (order matters for probe firing):

1. **Preamble**: `use r3_mem`, data segment init, name registration
2. **Per-function entry probes** (`opcode:*:before / opidx == 0 && fid == N /`): EC check + call_depth increment
3. **func:exit probes**: call_depth decrement
4. **IC probes** (`opcode:call:before`): import call detection + call_depth decrement
5. **IR probes** (`opcode:call:after`): import return with resN + call_depth increment
6. **Shadow probes**: store:before + load:after for L events
7. **Report probe**: `r3_mem.print_trace()`

## Known Failures (6/99)

### `replay_running_1`, `replay_running_2`, `replay_running_3`

Missing EC and IC/IR events. The `r3 main` function (excluded) is the `_start` entry point. When it calls a non-excluded export, `call_depth` should be 0 and EC should fire. But it doesn't.

**Suspected cause**: When the entry function (`_start`) is itself excluded, and it calls a non-excluded function whose first instruction is a `call` to another excluded function, there may be an interaction between the `opidx == 0` EC probe and the `call:before` IC probe firing on the same instruction. The `opcode:*:before` and `opcode:call:before` may not respect script ordering when they match the same instruction.

**Investigation needed**: Test whether `opcode:*:before` and `opcode:call:before` on the same instruction respect script order. If not, this is a whamm bug.

### `call-exp-func-from-imp-func-param`

Missing EC and IC/IR events. Similar pattern to replay tests — an excluded function calls back into a non-excluded export with parameters.

### `external-call`

Large real-world module (rust-wasm bindgen). Almost no events detected. Only one wrong L event. Likely multiple overlapping issues: many exports, complex call patterns, possibly whamm hitting performance or correctness limits on a large module.

### `table-imp-host-mod`

Missing IC and IR for a `call_indirect` to an excluded function. Our IC probe only handles `wasm:opcode:call:before`, not `wasm:opcode:call_indirect:before`. This is a known limitation — `call_indirect` support is deferred.

## Known whamm Bugs Encountered

### 1. Multiple `func:entry` probes — `localN` not in scope (FIXED on master)

Two `wasm:func:entry` probes in the same script caused `localN` type bounds to not be populated for the second probe. Fixed in whamm master as of 2026-03-30.

**Repro**: `whamm_bug_repro/` (removed since fixed)

### 2. Multiple `call:after` with different `resN` types — index panic (FIXED on master)

Multiple `wasm:opcode:call(resN: T):after` probes with different return types caused `removal index out of bounds` panic in `rules/mod.rs`. Root cause: `Vec::remove` in forward order without adjusting indices. Fixed in whamm master as of 2026-03-31.

**Repro**: `whamm_bug_repro/repro_test04_min.mm` + `test04_min.wat`

### 3. >2 probes on same `opcode:*:before` event — ordering not respected (OPEN)

When 3+ `wasm:opcode:*:before` probes with `opidx == 0` exist, the third probe may fire before the first two, violating script order. Workaround: use per-function probes instead of grouped probes to avoid >2 probes at the same location.

### 4. `func:entry` vs `opcode:call:before` insertion ordering (OPEN)

When `func:entry` and `opcode:call:before` target the same bytecode position (call is the first instruction), whamm inserts `call:before` code before `func:entry` code. This causes IC to fire before EC. Workaround: use `opcode:*:before / opidx == 0 /` for EC instead of `func:entry`.

### 5. `opcode:*:before` vs `opcode:call:before` ordering (SUSPECTED)

When both `opcode:*:before / opidx == 0 /` and `opcode:call:before` match the same `call` instruction, it's unclear whether script order is respected between a wildcard opcode match and a specific opcode match. This may explain the replay_running failures.

## whamm Features Used

- `active_data_start(APP_MEMID)` / `active_data_len(APP_MEMID)` — data segment access
- `memcpy(src_mem, src_addr, dst_mem, dst_addr, len)` — cross-memory copy
- `memid(r3_mem)` — get memory ID of user lib
- `write_str(memid, ptr, str_var)` — write string to user lib memory
- `report var` — one-time initialization trick
- `localN` type bounds on probes — access function arguments
- `resN` type bounds on `call:after` — access call return values
- `opidx` — instruction index within function (0 = first instruction)
- `fid` / `fname` — function ID and name in predicates
- `imm0` — call target function index
- `effective_addr` / `data_size` / `arg0` / `res0` — opcode operands
- `APP_MEMID` — application memory ID

## Not Yet Implemented

- **G (Global) events**: Global value change tracking. Would need `wasm:opcode:global.set:before` probes.
- **MG (MemGrow) events**: Memory growth tracking.
- **T (TableGet) events**: Table access tracking.
- **TC (TableCall) events**: `call_indirect` to exports. Would need `call_indirect:before/after` support in script_gen.
- **call_indirect for IC/IR**: Our IC/IR probes only handle `call:before/after`, not `call_indirect`. The `table-imp-host-mod` failure is due to this.
- **tc* tests**: The WASI test cases in `tests/` are compiled from Rust. They use `host_*` prefix instead of `r3*` for exclusion. Not currently tested by `test_one.sh` but the script_gen supports `--exclude "host_*"`.

## Historical Context

This project went through several phases:

1. **Hand-written .mm scripts** (`whamm_monitor/R3.mm`, `R3_r3exclude.mm`): Started with manual whamm scripts for L events only. Achieved 99/99 on L events with shadow memory + data segment initialization.

2. **script_gen approach**: Moved to a code generator that parses the target wasm and emits tailored `.mm` scripts. This enabled per-function probes with correct argument types, which is necessary for EC/IC/IR events.

3. **wirm exploration** (`../wirm-R3/`): Briefly explored using wirm (whamm's bytecode rewriting backend) directly for R3. This would give full control over instruction insertion but was abandoned in favor of staying with whamm per advisor's preference. The wirm-R3 folder contains a working parse/roundtrip/optimize pipeline and useful documentation in `useful_utils.md`.

4. **Bug discovery**: Several whamm bugs were discovered and reported during development, leading to fixes in whamm master. The bug repro folder at `../whamm_bug_repro/` contains minimal reproductions.

## Quirks and Gotchas

### `report var` trick
`report var x: i32 = some_func();` calls `some_func()` exactly once (first time the probe fires). The return value is stored but never used. This replaces `if (!inited) { inited = true; ... }` guards.

### `localN` overread suppresses probe
If you declare more `localN` bindings than a function has locals (params + local vars), the probe silently doesn't fire for that function. It doesn't error — it just skips. This is why per-signature grouping is necessary for EC probes.

### `localN` underread is fine
Declaring fewer `localN` bindings than the function has params works correctly — you just don't see the extra params.

### Export name vs debug name
The export section gives export names (e.g., `"entry"`, `"add"`). The name section gives debug names (e.g., `"r3 main"`, `"main"`). The exclude pattern matches on **debug names**. EC events report **export names**.

### Multiple exports for same function
A single function can have multiple export names (e.g., `_start` and `main` both export fid 0). The name table registers all of them, but the last one wins for display.

### Shadow memory uses Vec<u8>
The shadow is a flat `Vec<u8>` that grows on demand via `ensure_capacity`. This is much faster than the original `HashMap<u32, u8>` approach. Addresses beyond the Vec length are implicitly 0 (matching wasm's zero-initialized memory).

### Data segment initialization
Before any code runs, wasm data segments write initial values into linear memory. Without shadow initialization, `check_load` would see mismatches on every first read of data-segment-initialized memory. The `init_shadow` function copies the data segment bytes into the shadow Vec at startup, establishing the correct baseline.
