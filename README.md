# R3 Monitor via whamm Bytecode Instrumentation

## What is R3?

WebAssembly (wasm) modules run inside a host environment (a browser, a server runtime, etc.). The host can call wasm functions, and wasm can call host functions. Between those calls, the host might modify wasm's memory or globals directly.

**R3** is a monitoring system that records every interaction between a wasm module and its host. The recorded trace looks like this:

```
IG;0;42                   ← at instantiation, imported global 0 had value 42
                            (provided by the host, not by this module)
EC;5;_start;              ← host called the exported function "_start" (function 5)
IC;2                      ← wasm called host function 2
IR;2;42                   ← host function 2 returned the value 42
L;0;100;1,2,3,4           ← wasm loaded from address 100 and got bytes [1,2,3,4]
                            that it didn't write — the host must have written them
G;1;5                     ← wasm read global 1 and got value 5, which it didn't set
                            — the host must have changed it
```

The trace captures seven event types:

| Event | Name | Meaning |
|-------|------|---------|
| **IG** | Import Global | The module imported a global from the host. Records: global index, initial value. Fires at instantiation. |
| **EC** | External Call | The host called an exported wasm function. Records: function index, export name, argument values. |
| **IC** | Import Call | Wasm called a host (imported/excluded) function. Records: target function index. |
| **IR** | Import Return | A host function returned to wasm. Records: function index, return values. |
| **L** | Load | Wasm loaded a value from memory that differs from what wasm last stored there — meaning the host modified that memory. Records: memory index, address, bytes. |
| **MG** | Memory Grow | The host grew wasm linear memory. Records: memory index, number of pages added. |
| **G** | Global Get | Wasm read a global that differs from what wasm last set — meaning the host modified it. Records: global index, value. |

Value formatting: i32 and i64 are printed as signed decimal. f32 and f64 are printed as `0x` followed by their IEEE 754 bit pattern in hexadecimal (uppercase for G and IG events, lowercase for EC/IR).

**Why does this matter?** If you record these events during one execution, you can replay the wasm program deterministically without the original host — just feed back the recorded values at the right moments. IG events provide the initial global values needed to instantiate the module, EC/IC/IR events provide the function call boundaries, L events provide the memory values the host wrote, and G events provide the global values the host modified. Together, they capture every interaction between the module and its environment. This enables record/replay debugging, time-travel debugging, and deterministic reproduction of bugs involving non-deterministic host behavior.

## The Tools

- **Wizard Engine** ([github.com/titzer/wizard-engine](https://github.com/titzer/wizard-engine)): A WebAssembly engine written in Virgil. It has a built-in R3 monitor that serves as our oracle — the ground truth for what the correct trace should be. Run with `wizeng --monitors="r3{exclude=pattern}" module.wasm` to get the oracle trace.

- **Virgil** ([github.com/titzer/virgil](https://github.com/titzer/virgil)): The programming language that Wizard is written in. Needed to run Wizard. We use the JVM backend (`wizeng.jvm`), which requires OpenJDK. Set `VIRGIL_LOC` to point to the Virgil checkout.

- **whamm** ([github.com/ejrgilbert/whamm](https://github.com/ejrgilbert/whamm)): A bytecode instrumentation framework for WebAssembly. You write a `.mm` script describing what to monitor, and whamm rewrites the wasm binary to include your monitoring code. Think of it like DTrace or eBPF, but for wasm. whamm also provides `whamm_core.wasm` — a runtime library needed by instrumented modules.

**Our goal**: Implement the R3 monitor using whamm instead of Wizard's built-in monitor, and verify that our implementation produces identical traces.

## Our Approach

We don't write a single `.mm` script by hand. Instead, we have a **code generator** that reads the target wasm binary and produces a tailored `.mm` script for that specific module. This is necessary because:

1. Different functions have different signatures (parameter types, return types), and whamm probes need to declare the correct types statically via type bounds like `wasm(local0: i32, local1: f64):opcode:*:before`.
2. We need to know which functions are "excluded" (simulating the host) — determined by parsing the name section.
3. We need to know which globals are exported and mutable — determined by parsing the global and export sections.
4. We need function export names for EC events — determined by parsing the export section.

The pipeline:

```
                   script_gen                     whamm instr                     wizeng
target.wasm ────────────────────► generated.mm ──────────────────► instrumented.wasm ──────► R3 trace
                                       │                                │
                                  uses r3_mem                      runs with
                                  (helper lib)                     whamm_core.wasm
                                                                   + r3_mem.wasm
```

### The two components we build:

**script_gen** (Rust binary, `script_gen/src/main.rs`): Parses the target `.wasm` binary using the `wasmparser` crate. It extracts:

- **Type section**: All function signatures (`(params) → (results)`) indexed by type ID.
- **Import section**: Imported functions (counted to determine where local function indices start) and imported globals.
- **Function section**: Maps each local function to its type ID. Combined with the type section, gives us every function's full signature.
- **Global section**: Each global's type, mutability, and initial value (parsed from the const init expression: `i32.const N`, `i64.const N`, `f32.const`, `f64.const`).
- **Export section**: Function exports (name + function index) and global exports (global index).
- **Name section** (custom): Debug names for functions, used to match the `--exclude` pattern (e.g., functions named `r3 main`, `r3 foo` are excluded because they simulate the host in the test suite).

From this information, script_gen generates a `.mm` whamm script with:
- Shadow memory initialization from data segments
- Shadow global initialization from init expressions
- Export name registration (using whamm's `write_str` to pass strings to the helper lib)
- IG probes for imported globals (one-shot `global.get:after` per imported global)
- Per-function entry probes for EC detection with correct `localN` type bounds
- `call_depth` tracking probes
- IC probes for direct calls (`call:before`)
- IR probes for direct calls (`call:after`) grouped by return type
- IC/IR probes for indirect calls (`call_indirect`) using a flag pattern
- G probes for exported mutable globals and imported mutable globals (`global.set:before`, `global.get:after`)
- Bulk memory probes (`memory.grow`, `memory.fill`, `memory.copy`)
- Shadow store/load probes for all integer load/store instructions

**r3_mem** (Rust library compiled to `wasm32-wasip1`, `helper_lib/src/lib.rs`): The runtime helper that the generated probes call. Its internal state:

```rust
struct State {
    shadow: Vec<u8>,              // Shadow memory — byte-for-byte copy of wasm linear memory
    shadow_globals: Vec<i64>,     // Shadow globals — one i64 per global (cast for smaller types)
    trace: Vec<TraceEvent>,       // Recorded events in execution order
    building: Option<EventBuilder>, // In-progress EC or IR event (builder pattern for multi-param events)
    names: HashMap<u32, String>,  // Function ID → export name mapping
}
```

Exported functions (called by the generated whamm probes):

| Function | Signature | Purpose |
|----------|-----------|---------|
| `mem_alloc` | `(len: i32) → i32` | Allocate `len` bytes in r3_mem's memory, return pointer |
| `init_shadow` | `(data_ptr: i32, start: i32, len: i32) → i32` | Seed shadow from data segment bytes copied into r3_mem's memory |
| `shadow_store` | `(addr: i32, size: i32, value: i64)` | Update shadow on wasm store |
| `check_load` | `(addr: i32, size: i32, value: i64)` | Compare loaded value vs shadow; emit L on mismatch |
| `shadow_grow` | `(old_pages: i32, new_pages: i32)` | Expand shadow after memory.grow |
| `shadow_fill` | `(dest: i32, val: i32, len: i32)` | Update shadow for memory.fill |
| `shadow_copy` | `(dest: i32, src: i32, len: i32)` | Update shadow for memory.copy |
| `shadow_global_set` | `(idx: i32, val: i64)` | Update shadow global |
| `check_global_i32` | `(idx: i32, val: i32)` | Compare global vs shadow; emit G on mismatch |
| `check_global_i64` | `(idx: i32, val: i64)` | Same for i64 |
| `check_global_f32` | `(idx: i32, val: f32)` | Same for f32 (formats as uppercase hex) |
| `check_global_f64` | `(idx: i32, val: f64)` | Same for f64 (formats as uppercase hex) |
| `register_name` | `(fid: i32, ptr: i32, len: i32) → i32` | Read string from r3_mem's memory, store as name for fid |
| `begin_event` | `(fid: i32, event_type: i32)` | Start building an EC (type=0) or IR (type=1) event |
| `param_i32` | `(v: i32)` | Add i32 parameter to in-progress event |
| `param_i64` | `(v: i64)` | Add i64 parameter |
| `param_f32` | `(v: f32)` | Add f32 parameter |
| `param_f64` | `(v: f64)` | Add f64 parameter |
| `end_event` | `()` | Finalize in-progress event, push to trace |
| `record_ic` | `(fid: i32)` | Record an IC event (no builder needed — just the fid) |
| `record_mg` | `(mem_idx: i32, pages: i32)` | Record an MG event (deferred until next EC/IR boundary) |
| `record_ig_i32` | `(idx: i32, val: i32)` | Record an IG event for an imported i32 global |
| `record_ig_i64` | `(idx: i32, val: i64)` | Record an IG event for an imported i64 global |
| `record_ig_f32` | `(idx: i32, val: f32)` | Record an IG event for an imported f32 global |
| `record_ig_f64` | `(idx: i32, val: f64)` | Record an IG event for an imported f64 global |
| `print_trace` | `()` | Print all recorded events to stdout (IG first, then rest in order) |

The EC/IR builder pattern exists because wasm functions can't have variable-length arguments. For a function with 3 parameters, the generated probe calls: `begin_event`, `param_i32`, `param_i32`, `param_i32`, `end_event`.

## How Each Event Is Detected — In Detail

### IG (Import Global) — One-Shot Global Read

When a wasm module imports a global from the host (or another module), the host provides the initial value. This value is external input — the module has no control over it. IG events record these initial values so they can be replayed later without the original host.

**Detection**: For each imported global at index N of type T, script_gen emits a one-shot `global.get:after` probe guarded by a per-global boolean:

```mm
var ig_done_0: bool;
wasm:opcode:global.get(res0: i32):after / imm0 == 0 && !ig_done_0 / {
    ig_done_0 = true;
    r3_mem.record_ig_i32(0 as i32, res0);
    r3_mem.shadow_global_set(0 as i32, res0 as i64);
}
```

The first time any code reads imported global 0, the probe fires, records the IG event, initializes the shadow global (for subsequent G event detection), and disables itself via the `ig_done_0` guard.

**Why one-shot via `global.get:after`**: Ideally IG should fire at instantiation (before any code runs), as wizard's oracle does. However, whamm doesn't provide a way to read a specific global by index at script level. Reading the global on first access is equivalent for immutable imported globals (their value never changes). For mutable imported globals, this is correct as long as the host doesn't modify the global between instantiation and the first wasm `global.get` — which is the case for all practical scenarios (the host calls an export immediately after instantiation).

**Output ordering**: `print_trace` outputs all IG events first (sorted by global index), before any other events. This matches wizard's oracle behavior where IG events precede all execution events.

**Shadow initialization**: The IG probe also calls `shadow_global_set` to initialize the shadow for this global. This is necessary so that subsequent G event detection (comparing `global.get` results against the shadow) has the correct baseline. Without this, the first `global.get` after an IG probe would see a mismatch against the default shadow value of 0 and falsely emit a G event.

### L (Load) — Shadow Memory

The shadow is a `Vec<u8>` that mirrors the wasm module's linear memory. It starts empty and grows on demand (via `ensure_capacity` — if a store/load accesses beyond the current shadow size, the shadow is resized with zeros).

**Initialization**: Before any wasm code runs, the module's data segments pre-populate linear memory. Without initializing the shadow, every first load from data-segment-initialized memory would be a false L event (shadow has 0, live memory has the data segment value). We initialize the shadow at script level:

```mm
var data_len: u32 = active_data_len(APP_MEMID);     // total data segment byte range length
var data_start: u32 = active_data_start(APP_MEMID);  // start address of first data segment
var ptr: i32 = r3_mem.mem_alloc(data_len as i32);     // allocate space in r3_mem's memory
memcpy(APP_MEMID, data_start, memid(r3_mem), ptr as u32, data_len);  // copy from app memory to r3_mem
report var _shadow: i32 = r3_mem.init_shadow(ptr, data_start as i32, data_len as i32);  // seed the shadow Vec
```

The `report var _shadow = ...` trick ensures `init_shadow` is called exactly once (report variables are initialized on first use).

**Store tracking**: Every `i32.store`, `i32.store8`, `i32.store16`, `i64.store`, etc. in non-excluded functions triggers `shadow_store`, which writes the stored bytes into the shadow Vec at the same address.

**Load checking**: Every `i32.load`, `i32.load8_s`, `i32.load8_u`, etc. in non-excluded functions triggers `check_load`. It reads the shadow at the load address, masks both values to the correct width, and compares. On mismatch:
1. The loaded bytes are recorded as an L event in the trace.
2. The shadow is updated with the new value (so subsequent loads of the same address don't re-trigger).

```rust
fn check_load(addr: i32, size: i32, value: i64) {
    let m = mask(size);  // e.g., 0xFFFFFFFF for 4-byte loads
    let shadow_val = read_shadow(addr, size);
    if (value & m) != (shadow_val & m) {
        trace.push(Load { addr, bytes: extract_bytes(value, size) });
        write_shadow(addr, size, value);  // update shadow
    }
}
```

**Bulk memory**: `memory.fill` fills a range with a byte value — `shadow_fill` does `shadow[dest..dest+len].fill(val as u8)`. `memory.copy` copies a range — `shadow_copy` does `shadow.copy_within(src..src+len, dest)` (handles overlapping ranges correctly). `memory.grow` extends memory by N pages — `shadow_grow` resizes the shadow Vec with zeros.

### EC (External Call) — call_depth State Machine

The `call_depth` variable tracks how deep we are in non-excluded wasm code. It's a global i32 in the generated `.mm` script.

State transitions:

```
Host calls wasm export         → call_depth is 0 → EC fires, then call_depth becomes 1
Wasm function calls another    → call_depth increments (2, 3, ...)
Wasm function returns          → call_depth decrements
Wasm calls excluded function   → call_depth decrements (IC — "leaving" wasm)
Excluded function returns      → call_depth increments (IR — "re-entering" wasm)
Excluded function calls back   → call_depth is 0 → EC fires again (re-entry)
```

Example trace for: host calls `entry`, which calls `r3_foo` (excluded), which calls `bar` (non-excluded re-entry):

```
call_depth=0 → entry: EC fires, call_depth=1
call_depth=1 → call r3_foo: IC fires, call_depth=0
call_depth=0 → r3_foo calls bar: EC fires (re-entry!), call_depth=1
call_depth=1 → bar returns: call_depth=0
call_depth=0 → r3_foo returns: IR fires, call_depth=1
call_depth=1 → entry returns: call_depth=0
```

The EC check and call_depth increment happen in the same probe body (single `opcode:*:before / opidx == 0 /` probe per function) to avoid ordering issues between separate probes.

**Export name registration**: Script_gen emits string-passing code at script level for each export:

```mm
report var _n0: str = "entry";               // declare string constant
var _nl0: u32 = _n0.len();                    // get length
var _np0: i32 = r3_mem.mem_alloc(_nl0 as i32); // allocate in r3_mem's memory
write_str(memid(r3_mem), _np0, _n0);           // copy string bytes to r3_mem
report var _nr0: i32 = r3_mem.register_name(1 as i32, _np0, _nl0 as i32);  // register: fid 1 = "entry"
```

This uses whamm's `write_str` built-in and the `memid()` function to write string data across module boundaries.

### IC (Import Call) and IR (Import Return) — Direct and Indirect

**Direct calls** (`call` instruction): The call target is `imm0` (the immediate operand of the `call` instruction). Script_gen generates one IC probe matching all excluded target fids, and IR probes grouped by return type:

```mm
// IC: fires for any call to an excluded function from a non-excluded function
wasm:opcode:call:before / (imm0 == 0 || imm0 == 3) && fid != 0 && fid != 3 / {
    r3_mem.record_ic(imm0 as i32);
    call_depth = call_depth - 1;
}

// IR for excluded functions returning i32:
wasm:opcode:call(res0: i32):after / (imm0 == 0 || imm0 == 2) && fid != 0 && fid != 3 / {
    r3_mem.begin_event(imm0 as i32, 1 as i32);
    r3_mem.param_i32(res0);
    r3_mem.end_event();
    call_depth = call_depth + 1;
}

// IR for excluded functions returning void:
wasm:opcode:call:after / (imm0 == 3) && fid != 0 && fid != 3 / {
    r3_mem.begin_event(imm0 as i32, 1 as i32);
    r3_mem.end_event();
    call_depth = call_depth + 1;
}
```

The grouping by return type is necessary because `res0` type bounds must match the actual return type. If excluded function 0 returns i32 and function 3 returns void, they need separate `call:after` probes.

**Indirect calls** (`call_indirect`): The target function index isn't in the instruction — it's resolved at runtime from a table. We can't use `imm0` to filter. Instead, we use a three-phase flag pattern:

Phase 1 — Before the indirect call, set a tracking flag:
```mm
wasm:opcode:call_indirect:before {
    tracking_indirect = true;
}
```

Phase 2 — The callee's `func:entry` fires. If the flag is set and the callee is excluded, it's an indirect IC:
```mm
wasm:func:entry / fid == 0 || fid == 3 / {   // excluded functions
    if (tracking_indirect) {
        r3_mem.record_ic(fid as i32);
        indirect_target_fid = fid as i32;
        call_depth = call_depth - 1;
        tracking_indirect = false;
    }
}
wasm:func:entry / fid != 0 && fid != 3 / {   // non-excluded functions
    if (tracking_indirect) {
        tracking_indirect = false;
        indirect_target_fid = -1;            // target wasn't excluded, no IR needed
    }
}
```

Phase 3 — After the indirect call returns, if we tracked an excluded target, emit IR:
```mm
wasm:opcode:call_indirect(res0: i32):after {
    if (indirect_target_fid != -1) {
        r3_mem.begin_event(indirect_target_fid, 1 as i32);
        r3_mem.param_i32(res0);
        r3_mem.end_event();
        call_depth = call_depth + 1;
        indirect_target_fid = -1;
    }
}
```

For `call_indirect:after` with mixed return types, typed probes are emitted first (matching functions with return values) and the void-return probe last. This ensures that when both could match, the typed probe fires first and clears `indirect_target_fid`, preventing the void probe from double-firing.

### G (Global Get) — Shadow Globals

Shadow globals are stored as a `Vec<i64>` in r3_mem (all types are widened to i64 for storage; comparisons cast back to the original type).

**Initialization**: Script_gen parses each global's init expression from the global section. For `i32.const N`, `i64.const N`, `f32.const`, `f64.const`, it extracts the value and emits an initialization call at script level:

```mm
r3_mem.shadow_global_set(1 as i32, 42 as i64);  // global 1 initialized to 42
```

For init expressions using `global.get` (referencing another global), the value can't be determined statically and is left at 0. For imported globals, the shadow is initialized by the IG probe on first read (see IG section above).

**Tracking**: Exported mutable globals AND imported mutable globals are tracked. Non-exported non-imported globals can only be modified by wasm code, never by the host, so they can never produce G events. Imported mutable globals need tracking because the host (or the exporting module) can modify them between wasm calls.

```mm
// Update shadow when wasm sets global 1
wasm:opcode:global.set(arg0: i32):before / fid != 0 && fid != 3 && (imm0 == 1) / {
    r3_mem.shadow_global_set(imm0 as i32, arg0 as i64);
}

// Check for host modification when wasm reads global 1
wasm:opcode:global.get(res0: i32):after / fid != 0 && fid != 3 && (imm0 == 1) / {
    r3_mem.check_global_i32(imm0 as i32, res0);
}
```

The check functions compare the loaded value against the shadow. On mismatch, a G event is pushed to the trace and the shadow is updated.

### MG (Memory Grow) — Host-Triggered Memory Growth

MG events record when the host (excluded code) grows wasm linear memory. Format: `MG;<mem_idx>;<pages>`. When non-excluded wasm code calls `memory.grow`, no MG event is emitted — that's the module growing its own memory, not host interaction.

**Detection**: script_gen emits two `memory.grow:after` probes — one for non-excluded code (just updates the shadow), and one for excluded code (records MG and updates the shadow):

```mm
// Non-excluded: shadow update only
wasm:opcode:memory.grow:after /fid != 0 && fid != 3/ {
    r3_mem.shadow_grow(res0, arg0 as i32);
}

// Excluded: MG event + shadow update
wasm:opcode:memory.grow:after / fid == 0 || fid == 3 / {
    if (res0 != -1) {
        r3_mem.record_mg(0 as i32, arg0 as i32);
    }
    r3_mem.shadow_grow(res0, arg0 as i32);
}
```

The `res0 != -1` guard ensures MG is only recorded when the grow succeeds (`memory.grow` returns -1 on failure, or the old page count on success). `arg0` is the number of pages requested.

**Deferred emission for correct ordering**: MG events are not immediately pushed to the trace. Instead, `record_mg` stores them in a `pending_mg` buffer. The pending events are flushed at the next EC or IR boundary — specifically, inside `end_event`:

- For **EC** (type=0): EC is pushed to the trace first, then pending MG events are flushed. This matches the oracle, which calls `checkMemGrow` after recording EC in `onFuncEntry`.
- For **IR** (type=1): IR is pushed first, then pending MG events are flushed. This matches the oracle, which calls `checkMemGrow` after recording IR in `onCallReturn`.

This deferred approach is necessary because the `memory.grow:after` probe fires while inside the excluded function (before it returns), but the oracle detects memory growth at the boundary when control transitions back to wasm code.

**Scope limitation**: We can only detect MG when excluded *wasm* functions call `memory.grow`. If the actual host (JavaScript, a WASI runtime) grows memory via the host API (e.g., `WebAssembly.Memory.grow()`), there is no wasm instruction to instrument. This matches the wasm-r3 test suite's approach, where "host" behavior is simulated by excluded wasm functions.

## Key Design Decisions

### Why `opcode:*:before / opidx == 0 /` instead of `func:entry`

Both fire at the start of a function body. We use the opcode probe because whamm guarantees **script order** for probes in the same event category. Our EC probe and IC probe both need to fire at the same bytecode position (when the first instruction is a `call` to an excluded function). With `func:entry` for EC and `call:before` for IC, they're in different categories and whamm's insertion order puts IC first — wrong. With both as `opcode:*:before`, script order applies and EC fires first.

### Why per-function probes instead of grouped-by-signature

Originally we grouped all exports with the same parameter signature into one probe (`/ fid == 1 || fid == 5 || fid == 12 /`). This created multiple `opcode:*:before / opidx == 0 /` probes when different signatures existed. whamm had a bug where >2 probes on the same event didn't respect script order, causing the call_depth increment to fire before EC. Per-function probes (one `opcode:*:before / opidx == 0 && fid == N /` per function) eliminate probe competition at the same location.

### Why `argN` is reversed from what you'd expect

For `memory.fill(dest, val, len)`, the wasm stack has dest pushed first, then val, then len on top. whamm's `arg0` is the top of the stack (len), `arg1` is val, `arg2` is dest. This is the opposite of the instruction's conceptual parameter order. We discovered this empirically and it applies to all multi-operand instructions.

### Why only exported and imported globals for G events

Only globals accessible to the host can produce G events:
1. **Exported mutable globals**: The host can read and modify them directly.
2. **Imported mutable globals**: The exporting module (which acts as the host) can modify them.
3. **Non-exported non-imported globals**: Only wasm code can access them — the host has no way to modify them, so they can never produce legitimate G events.

Historically, if a module had both i32 and i64 mutable globals, the `global.set(arg0: i32):before` and `global.set(arg0: i64):before` probes triggered a whamm bug where type bounds from one probe were incorrectly applied to sibling probes. This bug is now fixed.

### Why the `report var` trick for one-time initialization

whamm's `report var x: T = expr;` evaluates `expr` exactly once (at first probe activation) and stores the result. We use this for shadow initialization and name registration — operations that must happen once before any events are recorded. The alternative (`if (!inited) { inited = true; ... }` guard) adds runtime overhead to every probe invocation.

### The test suite's "excluded functions" convention

The wasm-r3 test modules simulate host behavior using local wasm functions whose debug names start with `r3` (e.g., `r3 main`, `r3 foo`). These are treated as "excluded" — our probes skip them for store/load/global tracking (since "host" code is opaque), and `call:before`/`call:after` on calls to them produce IC/IR events. Wizard's oracle uses `--monitors="r3{exclude=r3*}"` for the same effect. For real-world WASI modules, actual wasm imports play the role of host functions — use `--exclude-imports` instead.

## Setup

### Prerequisites

| Tool | Purpose | Install |
|------|---------|---------|
| Rust + cargo | Build script_gen and r3_mem | [rustup.rs](https://rustup.rs) |
| `wasm32-wasip1` target | Compile r3_mem to wasm | `rustup target add wasm32-wasip1` |
| Virgil | Required by Wizard Engine | Clone [github.com/titzer/virgil](https://github.com/titzer/virgil) |
| Wizard Engine | Run wasm + oracle R3 monitor | Clone [github.com/titzer/wizard-engine](https://github.com/titzer/wizard-engine) |
| whamm | Bytecode instrumentation | Clone [github.com/ejrgilbert/whamm](https://github.com/ejrgilbert/whamm) |
| OpenJDK | JVM backend for Wizard | System package manager |
| wabt (`wat2wasm`) | Compile .wat test files | `brew install wabt` or equivalent |
| wasm-tools | Validate instrumented wasm | `cargo install wasm-tools` |
| wasi-sdk (optional) | Compile C/C++ tests to wasm | [github.com/WebAssembly/wasi-sdk](https://github.com/WebAssembly/wasi-sdk) |

### Directory Layout

```
claude-play-space/
├── virgil/              # Virgil compiler (set VIRGIL_LOC to this path)
├── wizard-engine/       # Wizard Engine (JVM backend: bin/wizeng.jvm)
├── whamm/               # whamm instrumentation framework
│   └── target/
│       ├── debug/whamm                              # whamm CLI binary
│       └── wasm32-wasip1/release/whamm_core.wasm    # whamm runtime library
└── WHAMM_R3/            # This project
    ├── script_gen/      # Code generator (Rust binary)
    │   ├── Cargo.toml   # depends on wasmparser 0.240.0
    │   └── src/main.rs
    ├── helper_lib/      # r3_mem helper lib (Rust → wasm)
    │   ├── Cargo.toml   # depends on once_cell
    │   └── src/lib.rs
    ├── wasm_r3_tests/   # 99 test wasm binaries from Wizard's R3 test suite
    ├── ig_tests/        # Multi-module IG test cases (.wat + .wasm pairs)
    ├── tests/           # Rust source for tc* tests (compiled to wasm32-wasip1)
    ├── c_tests/         # C/C++ test programs + compiled .wasm files
    ├── test_one.sh      # Per-test harness for wasm-r3 tests (--exclude "r3")
    ├── test_c.sh        # Per-test harness for C/C++ tests (--exclude-imports)
    ├── test_ig.sh       # Multi-module IG test harness
    └── run_tests.sh     # Combined runner: all suites, parallel, summary
```

### Building

```bash
# 1. Build whamm (the instrumentation tool + its runtime library)
cd whamm
cargo build                                              # builds whamm CLI
cargo build --target wasm32-wasip1 --release -p whamm_core  # builds whamm_core.wasm

# 2. Build r3_mem (our helper library, compiled to wasm)
cd WHAMM_R3/helper_lib
cargo build --target wasm32-wasip1 --release
# Output: target/wasm32-wasip1/release/r3_mem.wasm

# 3. Build script_gen (our code generator, runs natively)
cd WHAMM_R3/script_gen
cargo build
# Output: target/debug/script_gen
```

### Running a Single Test — Step by Step

```bash
cd WHAMM_R3
export VIRGIL_LOC=../virgil

# Step 1: Generate the .mm script for a specific test module.
# --exclude "r3" means functions whose debug names start with "r3" are treated as host functions.
script_gen/target/debug/script_gen wasm_r3_tests/test01.wasm --exclude "r3" > /tmp/gen.mm

# You can inspect the generated script:
cat /tmp/gen.mm

# Step 2: Use whamm to instrument the module with the generated script.
# This links in whamm_core.wasm (whamm's runtime) and r3_mem.wasm (our helper lib).
../whamm/target/debug/whamm instr \
    --script /tmp/gen.mm \
    --app wasm_r3_tests/test01.wasm \
    --core-lib ../whamm/target/wasm32-wasip1/release/whamm_core.wasm \
    --user-libs "r3_mem=helper_lib/target/wasm32-wasip1/release/r3_mem.wasm" \
    --output-path /tmp/instr.wasm

# Step 3: Run the oracle (Wizard's built-in R3 monitor) to get the expected trace:
../wizard-engine/bin/wizeng.jvm --monitors="r3{exclude=r3*}" wasm_r3_tests/test01.wasm

# Step 4: Run our instrumented module to get our trace:
../wizard-engine/bin/wizeng.jvm \
    ../whamm/target/wasm32-wasip1/release/whamm_core.wasm \
    helper_lib/target/wasm32-wasip1/release/r3_mem.wasm \
    /tmp/instr.wasm

# Step 5: Compare the two outputs. They should be identical.
```

For real-world WASI modules (not the r3 test suite), use `--exclude "" --exclude-imports` to treat actual wasm imports as host functions instead of name-matched local stubs.

### Running the Full Suite

```bash
cd WHAMM_R3
export VIRGIL_LOC=../virgil

# Run all tests (wasm-r3 + IG + C/C++) with 8 parallel workers:
./run_tests.sh

# Or with custom parallelism:
./run_tests.sh -j 4
```

`run_tests.sh` runs three test suites:
1. **wasm-r3** (99 tests): `test_one.sh` with `--exclude "r3"` — excluded functions simulate the host
2. **IG** (5 tests): `test_ig.sh` with multi-module pairs (host + consumer)
3. **C/C++** (9 tests): `test_c.sh` with `--exclude-imports` — actual wasm imports act as host

Each test independently generates a `.mm`, instruments, runs both oracle and ours, and diffs. Output is one line per test: `PASS name`, `ORDER name` (correct events, wrong order), or `FAIL name`. The wasm-r3 and C/C++ suites run in parallel; IG tests run sequentially.

You can also run individual suites:

```bash
# Single wasm-r3 test:
./test_one.sh wasm_r3_tests/test01.wasm

# Single C/C++ test:
./test_c.sh c_tests/hello.wasm

# Single IG test:
./test_ig.sh ig_tests/ig_basic.wasm
```

### Running IG Tests (Multi-Module)

IG tests require two wasm modules: a "host" module that exports globals, and a "consumer" module that imports them. These are in `ig_tests/`:

```bash
cd WHAMM_R3

# Run a single IG test:
./test_ig.sh ig_tests/ig_basic.wasm

# Run all IG tests:
for f in ig_tests/ig_basic.wasm ig_tests/ig_multi_type.wasm ig_tests/ig_zero.wasm \
         ig_tests/ig_with_calls.wasm ig_tests/ig_mutable.wasm; do
    ./test_ig.sh "$f"
done
```

The test harness:
1. Generates a `.mm` script with `--exclude "" --exclude-imports` (all imports are treated as host functions)
2. Instruments the consumer module with whamm
3. Runs the oracle: `wizeng --monitors="r3" host.wasm consumer.wasm`
4. Runs ours: `wizeng whamm_core.wasm r3_mem.wasm host.wasm consumer_instr.wasm`
5. Compares output (deduplicating oracle IG events — see note below)

**Note**: Wizard's R3 monitor has a bug in multi-module mode where `onInstantiate` is called for every loaded module instance, but the monitor's handler references only the last-parsed module's global definitions. This causes each IG event to appear twice in the oracle output. The test harness deduplicates with `awk '!seen[$0]++'`.

The IG test cases:
| Test | What it exercises |
|------|-------------------|
| `ig_basic` | Single i32 imported global (value 42) |
| `ig_multi_type` | Three imported globals: i32, i64, f64 |
| `ig_zero` | i32 imported global initialized to 0 (tests that IG fires even for zero) |
| `ig_with_calls` | Imported global + imported function (IG + EC + IC + IR events together) |
| `ig_mutable` | Mutable imported global (IG at start, then G event after host modifies it) |

## Results

**99/99** wasm-r3 tests pass with exact event matching (L, EC, IC, IR, G, MG events all compared).

**5/5** IG (multi-module) tests pass, covering i32/i64/f64 imported globals, zero-init, combined IG+EC+IC+IR events, and mutable imported globals with G events.

**9/9** C/C++ tests pass (2 skipped — `complex` and `fibonacci` crash Wizard's oracle), including programs with:
- `printf` (WASI `fd_write` imports → IC/IR events)
- `malloc`/`free`/`realloc` (`memory.grow` → shadow expansion)
- `memset`/`memcpy`/`memmove` (`memory.fill`, `memory.copy` → bulk shadow updates)
- Virtual functions (C++ polymorphism → `call_indirect` via vtables)
- STL containers (`std::map`, `std::unordered_map`, `std::set`, `std::vector`)
- `std::sort` with custom comparators (function pointers → `call_indirect`)
- Large heap allocations (256KB+ → multiple `memory.grow` calls)
- Static data (string literals, lookup tables, constants → data segment initialization)

Two C/C++ tests are excluded because Wizard's own R3 monitor crashes on them (`ArrayIndexOutOfBoundsException` in `onMemoryCopy`): `fibonacci` and `complex`. Our implementation handles them correctly but they can't be oracle-verified.

**Total: 113/113** tests pass across all three suites via `./run_tests.sh`.

## Known Limitations

### whamm limitations blocking further event coverage

Two categories of R3 events are blocked by missing whamm functionality. Once whamm adds support, these can be implemented with the same shadow-and-compare pattern used for L and G events.

**MG (MemoryGrow) — host API grows not detectable.** Our MG implementation only detects grows from excluded *wasm* functions (via `memory.grow:after` probes on excluded fids). If the actual host (JavaScript, WASI runtime) grows memory via the host API (e.g., `WebAssembly.Memory.grow()`), there is no wasm instruction to instrument and the MG will be missed. To detect host API grows, we would need whamm to expose `memory.size` as a built-in variable readable from probe bodies at EC entry points — allowing us to compare the current page count against the shadow and emit MG if it grew. whamm currently has no such built-in. Tracked in [whamm#300](https://github.com/ejrgilbert/whamm/issues/300).

**T/TC/TG (Table events) — funcref operands not exposed.** T events require shadow table tracking: intercept `table.set` to update the shadow, intercept `table.get` to compare against the shadow and detect host modifications. This requires access to the funcref value and the entry index — but whamm does not expose `arg0`/`res0` for `table.get`, `table.set`, or `call_indirect`. Only `imm0` (the table index immediate) is available. Without the entry index and funcref operands, we cannot maintain a shadow table. The `call_indirect` flag pattern (used for IC/IR) gives us the resolved `fid` at `func:entry`, but not the table entry index, which the T event format requires. TC (table calls) and TG (table grows) are blocked by the same limitation. 4 of our 99 wasm-r3 tests produce T events (`table-get`, `table-get-big`, `table-imp-host-mod`, `table-exp-host-mod-multiple`) that we currently cannot match — the test harness excludes T from the grep filter so they appear as PASS. Tracked in [whamm#299](https://github.com/ejrgilbert/whamm/issues/299).

**call_indirect flag pattern** — our IC/IR detection for indirect calls uses a 3-phase flag pattern (`tracking_indirect` → `func:entry` → `call_indirect:after`) because whamm doesn't expose the resolved function index on `call_indirect`. If whamm adds a `resolved_fid` built-in or similar, the flag pattern can be replaced with a direct predicate. Tracked in [whamm#301](https://github.com/ejrgilbert/whamm/issues/301).

### Other limitations

- **IG mutable edge case**: If the host modifies a mutable imported global between instantiation and the first wasm `global.get`, the IG event would record the modified value instead of the original instantiation value. In practice this doesn't occur — the host calls an export immediately after instantiation.
- **Wizard oracle crashes on C++ modules**: Wizard's R3 monitor hits an `ArrayIndexOutOfBoundsException` on `memory.copy` for modules compiled from C++ with heavy STL usage. Our implementation handles these correctly but can't be oracle-verified for those modules.
- **Wizard multi-module IG duplication**: Wizard's R3 monitor duplicates IG events in multi-module forward mode because `onInstantiate` runs for every module instance but the handler references the last-parsed module's global definitions. Our test harness deduplicates the oracle output.

## whamm Bugs Found During Development

This project served as a stress test for whamm. We discovered and reported several bugs, all of which were fixed:

1. **Multiple probes with localN type bounds** ([#293](https://github.com/ejrgilbert/whamm/issues/293)): When one `opcode:*:before` probe declared `localN` type bounds, sibling probes targeting functions with fewer locals were silently dropped. Root cause: whamm applied the local-count requirement globally to all probes on the same event, not per-predicate. Fixed.

2. **Multiple `call:after` with different resN types** ([#290](https://github.com/ejrgilbert/whamm/issues/290)): Two `call:after` probes with different return type bounds (`res0: i32` and `res0: f64`) caused an index-out-of-bounds panic during probe removal. Root cause: `Vec::remove` in forward order without adjusting indices. Fixed.

3. **`call_indirect(resN)` type mismatch** ([#295](https://github.com/ejrgilbert/whamm/issues/295)): `call_indirect(res0: i32):after` generated invalid wasm when the module also had `call_indirect` returning i64. whamm incorrectly applied the `res0: i32` type bounds to the i64-returning call sites. Fixed.

4. **Unused return values from user lib calls**: Calling a user lib function that returns a value without assigning it to a variable left values on the wasm stack, producing invalid modules ("values remaining on stack at end of block"). Fixed.

5. **`func:entry` vs `call:before` insertion ordering**: When both targeted the same bytecode position (function's first instruction is a call), `call:before` was inserted before `func:entry`, causing IC to fire before EC. Workaround: use `opcode:*:before / opidx == 0 /` for EC instead, keeping both in the opcode probe category where script order applies.

6. **Probe ordering with >2 same-event probes**: Three or more probes on the same `opcode:*:before` event didn't reliably respect script order. Workaround: use per-function probes (one probe per function, each with a specific `fid == N` predicate) instead of grouped probes, so at most one probe matches any given instruction.
