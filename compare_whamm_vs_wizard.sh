#!/usr/bin/env bash
# Compare whamm R3 instrumentation vs wizard R3 monitor for all test cases.
# Compares L (load) events only.
# Covers: tc*.wasm (exclude=host_*) and wasm_r3_tests (exclude=r3*)

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WASM_DIR="$SCRIPT_DIR/tests/target/wasm32-wasip1/debug"
TMP_DIR="$SCRIPT_DIR/tmp"
WHAMM_MONITOR="$SCRIPT_DIR/whamm_monitor/R3.mm"
WHAMM_MONITOR_R3EXCL="$SCRIPT_DIR/whamm_monitor/R3_r3exclude.mm"
R3_MEM_WASM="$SCRIPT_DIR/helper_lib/target/wasm32-wasip1/release/r3_mem.wasm"
WHAMM_CORE="$SCRIPT_DIR/../whamm/target/wasm32-wasip1/release/whamm_core.wasm"
WHAMM="$SCRIPT_DIR/../whamm/target/debug/whamm"
WIZENG="$SCRIPT_DIR/../wizard-engine/bin/wizeng.jvm"
export VIRGIL_LOC="$SCRIPT_DIR/../virgil"

mkdir -p "$TMP_DIR"

PASS=0; FAIL=0; TOTAL=0
FAIL_NAMES=()

for WASM in $(ls "$WASM_DIR"/tc*.wasm | sort); do
    NAME="$(basename "$WASM" .wasm)"
    TOTAL=$((TOTAL + 1))
    INSTR_WASM="$TMP_DIR/${NAME}_instr.wasm"

    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  $NAME"

    # --- Oracle: wizard R3 monitor ---
    ORACLE="$("$WIZENG" --monitors="r3{exclude=host_*}" "$WASM" 2>&1 | grep '^L;' || true)"

    # --- Instrument with whamm ---
    INSTR_ERR="$("$WHAMM" instr \
        --script "$WHAMM_MONITOR" \
        --app "$WASM" \
        --core-lib "$WHAMM_CORE" \
        --user-libs "r3_mem=$R3_MEM_WASM" \
        --output-path "$INSTR_WASM" 2>&1)" && INSTR_RC=0 || INSTR_RC=$?

    if [[ $INSTR_RC -ne 0 ]]; then
        echo "  [INSTR FAIL rc=$INSTR_RC]"
        echo "$INSTR_ERR" | head -10
        FAIL=$((FAIL + 1))
        FAIL_NAMES+=("$NAME (instr error)")
        echo
        continue
    fi

    # --- Run instrumented wasm ---
    WHAMM_OUT="$("$WIZENG" "$WHAMM_CORE" "$R3_MEM_WASM" "$INSTR_WASM" 2>&1 | grep '^L;' || true)"

    # --- Compare ---
    DIFF="$(diff <(echo "$ORACLE") <(echo "$WHAMM_OUT") || true)"

    ORACLE_COUNT=$(echo "$ORACLE" | grep -c '^L;' || true)
    WHAMM_COUNT=$(echo "$WHAMM_OUT" | grep -c '^L;' || true)

    if [[ -z "$DIFF" ]]; then
        echo "  PASS  (oracle=$ORACLE_COUNT L events, whamm=$WHAMM_COUNT L events)"
        PASS=$((PASS + 1))
    else
        echo "  FAIL  (oracle=$ORACLE_COUNT L events, whamm=$WHAMM_COUNT L events)"
        MISSING=$(diff <(echo "$ORACLE") <(echo "$WHAMM_OUT") | grep '^<' | sed 's/^< /  MISSING: /')
        EXTRA=$(diff <(echo "$ORACLE") <(echo "$WHAMM_OUT") | grep '^>' | sed 's/^> /  EXTRA:   /')
        [[ -n "$MISSING" ]] && echo "$MISSING"
        [[ -n "$EXTRA" ]]   && echo "$EXTRA"
        FAIL=$((FAIL + 1))
        FAIL_NAMES+=("$NAME")
    fi
    echo
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  tc* RESULT: $PASS/$TOTAL passed, $FAIL failed"
if [[ ${#FAIL_NAMES[@]} -gt 0 ]]; then
    echo "  Failed: ${FAIL_NAMES[*]}"
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo

# ── wasm_r3_tests (exclude=r3*) ────────────────────────────────────────────
echo "=== wasm_r3_tests (exclude=r3*, script=R3_r3exclude.mm) ==="
echo

R3_PASS=0; R3_FAIL=0; R3_TOTAL=0
R3_FAIL_NAMES=()

for WASM in $(ls "$SCRIPT_DIR/wasm_r3_tests"/*.wasm | grep -v '\.index\.wasm' | sort); do
    NAME="$(basename "$WASM" .wasm)"
    R3_TOTAL=$((R3_TOTAL + 1))
    INSTR_WASM="$TMP_DIR/r3_${NAME}_instr.wasm"

    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  [wasm-r3] $NAME"

    # --- Oracle: wizard R3 monitor ---
    ORACLE="$("$WIZENG" --monitors="r3{exclude=r3*}" "$WASM" 2>&1 | grep '^L;' || true)"

    # --- Instrument with whamm (r3* exclude script) ---
    INSTR_ERR="$("$WHAMM" instr \
        --script "$WHAMM_MONITOR_R3EXCL" \
        --app "$WASM" \
        --core-lib "$WHAMM_CORE" \
        --user-libs "r3_mem=$R3_MEM_WASM" \
        --output-path "$INSTR_WASM" 2>&1)" && INSTR_RC=0 || INSTR_RC=$?

    if [[ $INSTR_RC -ne 0 ]]; then
        echo "  [INSTR FAIL rc=$INSTR_RC]"
        echo "$INSTR_ERR" | head -10
        R3_FAIL=$((R3_FAIL + 1))
        R3_FAIL_NAMES+=("$NAME (instr error)")
        echo
        continue
    fi

    # --- Run instrumented wasm ---
    WHAMM_OUT="$("$WIZENG" "$WHAMM_CORE" "$R3_MEM_WASM" "$INSTR_WASM" 2>&1 | grep '^L;' || true)"

    # --- Compare ---
    DIFF="$(diff <(echo "$ORACLE") <(echo "$WHAMM_OUT") || true)"

    ORACLE_COUNT=$(echo "$ORACLE" | grep -c '^L;' || true)
    WHAMM_COUNT=$(echo "$WHAMM_OUT" | grep -c '^L;' || true)

    if [[ -z "$DIFF" ]]; then
        echo "  PASS  (oracle=$ORACLE_COUNT L events, whamm=$WHAMM_COUNT L events)"
        R3_PASS=$((R3_PASS + 1))
    else
        echo "  FAIL  (oracle=$ORACLE_COUNT L events, whamm=$WHAMM_COUNT L events)"
        MISSING=$(diff <(echo "$ORACLE") <(echo "$WHAMM_OUT") | grep '^<' | sed 's/^< /  MISSING: /')
        EXTRA=$(diff <(echo "$ORACLE") <(echo "$WHAMM_OUT") | grep '^>' | sed 's/^> /  EXTRA:   /')
        [[ -n "$MISSING" ]] && echo "$MISSING"
        [[ -n "$EXTRA" ]]   && echo "$EXTRA"
        R3_FAIL=$((R3_FAIL + 1))
        R3_FAIL_NAMES+=("$NAME")
    fi
    echo
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  wasm-r3 RESULT: $R3_PASS/$R3_TOTAL passed, $R3_FAIL failed"
if [[ ${#R3_FAIL_NAMES[@]} -gt 0 ]]; then
    echo "  Failed: ${R3_FAIL_NAMES[*]}"
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo
TOTAL_ALL=$((TOTAL + R3_TOTAL))
PASS_ALL=$((PASS + R3_PASS))
FAIL_ALL=$((FAIL + R3_FAIL))
echo "  GRAND TOTAL: $PASS_ALL/$TOTAL_ALL passed, $FAIL_ALL failed"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
