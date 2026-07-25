#!/usr/bin/env bash
# Test a multi-module IG test case. Takes the consumer .wasm as argument.
# The host module is derived by appending _host to the name.
# Outputs one line: PASS|FAIL <name>
set -u
source "$(dirname "$0")/test_common.sh"
WASM="$1"
NAME="$(basename "$WASM" .wasm)"
DIR="$(dirname "$WASM")"
HOST="${DIR}/${NAME}_host.wasm"

TMP="/tmp/r3_ig_$$_${NAME}"

"$SCRIPT_GEN" "$WASM" --exclude "" --exclude-imports > "${TMP}.mm" 2>/dev/null \
    || { echo "FAIL $NAME (gen)"; exit 0; }

"$WHAMM" instr --script "${TMP}.mm" --app "$WASM" \
    --core-lib "$WHAMM_CORE" --user-libs "r3_mem=$R3_MEM" \
    --output-path "${TMP}_instr.wasm" 2>/dev/null \
    || { echo "FAIL $NAME (instr)"; rm -f "${TMP}"*; exit 0; }

# Oracle: deduplicate IG events only (wizard bug in multi-module mode).
# Deduping the whole trace would collapse legitimately repeated lines,
# e.g. an import called twice producing two identical IC lines.
ORACLE=$($WIZENG --monitors="r3" "$HOST" "$WASM" 2>&1 \
    | grep -E '^(L|EC|IC|IR|G|MG|IG);' \
    | awk '/^IG;/ { if (seen[$0]++) next } { print }' || true)

OURS=$($WIZENG "$WHAMM_CORE" "$R3_MEM" "$HOST" "${TMP}_instr.wasm" 2>&1 \
    | grep -E '^(L|EC|IC|IR|G|MG|IG);' || true)

rm -f "${TMP}"*

if [[ "$ORACLE" == "$OURS" ]]; then
    echo "PASS $NAME"
else
    echo "FAIL $NAME"
fi
