#!/usr/bin/env bash
# Test a multi-module IG test case. Takes the consumer .wasm as argument.
# The host module is derived by appending _host to the name.
# Outputs one line: PASS|FAIL <name>
set -u
WASM="$1"
NAME="$(basename "$WASM" .wasm)"
DIR="$(dirname "$WASM")"
HOST="${DIR}/${NAME}_host.wasm"

SCRIPT_GEN=script_gen/target/debug/script_gen
WHAMM=../whamm/target/debug/whamm
WHAMM_CORE=../whamm/target/wasm32-wasip1/release/whamm_core.wasm
R3_MEM=helper_lib/target/wasm32-wasip1/release/r3_mem.wasm
WIZENG=../wizard-engine/bin/wizeng.jvm

TMP="/tmp/r3_ig_$$_${NAME}"

"$SCRIPT_GEN" "$WASM" --exclude "" --exclude-imports > "${TMP}.mm" 2>/dev/null \
    || { echo "FAIL $NAME (gen)"; exit 0; }

"$WHAMM" instr --script "${TMP}.mm" --app "$WASM" \
    --core-lib "$WHAMM_CORE" --user-libs "r3_mem=$R3_MEM" \
    --output-path "${TMP}_instr.wasm" 2>/dev/null \
    || { echo "FAIL $NAME (instr)"; rm -f "${TMP}"*; exit 0; }

# Oracle: deduplicate IG events (wizard bug in multi-module mode)
ORACLE=$("$WIZENG" --monitors="r3" "$HOST" "$WASM" 2>&1 \
    | grep -E '^(L|EC|IC|IR|G|MG|IG);' | awk '!seen[$0]++' || true)

OURS=$("$WIZENG" "$WHAMM_CORE" "$R3_MEM" "$HOST" "${TMP}_instr.wasm" 2>&1 \
    | grep -E '^(L|EC|IC|IR|G|MG|IG);' || true)

rm -f "${TMP}"*

if [[ "$ORACLE" == "$OURS" ]]; then
    echo "PASS $NAME"
else
    echo "FAIL $NAME"
fi
