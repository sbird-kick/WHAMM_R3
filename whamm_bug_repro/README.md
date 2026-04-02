# whamm bug repros

## repro_ci_type: `call_indirect(res0: T):after` type mismatch

`call_indirect(res0: i32):after` generates invalid wasm when the module also has `call_indirect` instructions returning a different type (e.g., i64). whamm should skip the probe for mismatched call sites but instead instruments them with the wrong type.

### Files
- `repro_ci_type.wat` — module with two `call_indirect`: one returns i32, one returns i64
- `repro_ci_type.mm` — probe targeting only i32 returns
- `repro_ci_type.wasm` — compiled from .wat

### Reproduce
```bash
wat2wasm repro_ci_type.wat -o repro_ci_type.wasm
whamm instr --script repro_ci_type.mm --app repro_ci_type.wasm --core-lib whamm_core.wasm -o out.wasm
wasm-tools validate out.wasm
```

### Expected
Valid wasm — probe is only applied to the i32-returning `call_indirect`.

### Actual
```
error: func 17 failed to validate
  type mismatch: expected i32, found i64
```
