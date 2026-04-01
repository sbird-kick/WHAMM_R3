# whamm bug: `opcode:*:before` probe with `localN` type bounds suppresses other probes

## Status: MINIMAL REPRO NOT YET FOUND

The bug is confirmed but we haven't isolated the exact trigger condition.

## What we know

When the full generated `.mm` script for `replay_running_1.wasm` is used, the
EC probe for fid=2 (no params) silently stops firing. The EC probe for fid=1
(has `local0: i32, local1: i32` type bounds) works fine.

### Confirmed through binary search:

1. **fid=2 probe alone → WORKS** (EC;2;entry; is emitted)
2. **fid=2 + fid=1 probes (simple bodies, e.g. `record_ic`) → WORKS** (both fire)
3. **fid=2 + fid=1 probes (complex bodies with `begin_ec`/`end_ec`) → BROKEN** (fid=2 suppressed)
4. **fid=2 + fid=1 probes (complex bodies) + IC probe → BROKEN**
5. **fid=2 + fid=1 probes (complex bodies) + IR probe → BROKEN**
6. **Both probes WITHOUT type bounds (complex bodies) → WORKS** (both fire)
7. **Simple repro.wat module with same probe pattern → WORKS** (doesn't reproduce)

So the bug requires:
- Two `opcode:*:before` probes where one has `localN` type bounds
- Complex probe bodies (calling multiple r3_mem functions like `begin_ec`/`end_ec`)
- The specific module structure of `replay_running_1.wasm` (4 functions, 2 excluded)
- The simple 3-function `repro.wat` does NOT trigger it

### Next step to find minimal repro

Start from `strip1.mm` (the full script minus shadow/name-registration boilerplate)
which IS broken against `replay_running_1.wasm`, and keep stripping:

```bash
cd ~/test_WHAMM_R3
export VIRGIL_LOC=~/virgil

# This is confirmed broken (only outputs EC;1;changeMemWasm;0,0, missing EC;2;entry;):
../whamm/target/debug/whamm instr \
    --script whamm_bug_repro/strip1.mm \
    --app wasm_r3_tests/replay_running_1.wasm \
    --core-lib ../whamm/target/wasm32-wasip1/release/whamm_core.wasm \
    --user-libs "r3_mem=helper_lib/target/wasm32-wasip1/release/r3_mem.wasm" \
    --output-path /tmp/strip1_instr.wasm

../wizard-engine/bin/wizeng.x86-64-linux \
    ../whamm/target/wasm32-wasip1/release/whamm_core.wasm \
    helper_lib/target/wasm32-wasip1/release/r3_mem.wasm \
    /tmp/strip1_instr.wasm

# Expected: EC;2;entry; then IC;3 IR;3; (x3) then EC;1;changeMemWasm;0,0
# Actual:   EC;1;changeMemWasm;0,0
```

Try:
- Remove IC probe → still broken?
- Remove IR probe → still broken?
- Remove func:exit → still broken?
- Simplify probe bodies (replace begin_ec/end_ec with record_ic) → works?
- Make both probes have type bounds → works?
- Make neither have type bounds → works?

If the module structure matters, try building a .wat that matches replay_running_1's
structure (4 funcs, 2 with params, specific call graph) instead of the trivial repro.wat.

## Impact

This blocks 4 of our 6 remaining test failures:
- replay_running_1, replay_running_2, replay_running_3
- call-exp-func-from-imp-func-param

All share the same pattern: non-excluded exported functions with different signatures
need per-function `opcode:*:before` probes, and the ones without localN type bounds
get silently dropped.

## Related whamm commits

- `64ad8de` "Fixes #290: remove mismatched probes in rev order of target indices" —
  fixed the same class of bug for `resN` type bounds on `call:after`. The `localN`
  path in `rules/mod.rs` likely has the same index-shifting bug during probe removal.
