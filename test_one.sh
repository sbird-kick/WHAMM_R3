#!/usr/bin/env bash
# Test a single wasm file. Outputs one line: PASS|ORDER|FAIL <name>
set -u
source "$(dirname "$0")/test_common.sh"
WASM="$1"
NAME="$(basename "$WASM" .wasm)"

TMP="/tmp/r3_test_$$_${NAME}"

"$SCRIPT_GEN" "$WASM" --exclude "r3" > "${TMP}.mm" 2>/dev/null || { echo "FAIL $NAME (gen)"; exit 0; }

"$WHAMM" instr --script "${TMP}.mm" --app "$WASM" \
    --core-lib "$WHAMM_CORE" --user-libs "r3_mem=$R3_MEM" \
    --output-path "${TMP}_instr.wasm" 2>/dev/null || { echo "FAIL $NAME (instr)"; rm -f "${TMP}"*; exit 0; }

ORACLE=$($WIZENG --monitors="r3{exclude=r3*}" "$WASM" 2>&1 \
    | grep -E '^(L|EC|IC|IR|G|MG);' || true)

OURS=$($WIZENG "$WHAMM_CORE" "$R3_MEM" "${TMP}_instr.wasm" 2>&1 \
    | grep -E '^(L|EC|IC|IR|G|MG);' || true)

rm -f "${TMP}"*

if [[ "$ORACLE" == "$OURS" ]]; then
    echo "PASS $NAME"
elif [[ "$(echo "$ORACLE" | sort)" == "$(echo "$OURS" | sort)" ]]; then
    echo "ORDER $NAME"
else
    echo "FAIL $NAME"
fi
