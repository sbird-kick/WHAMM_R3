#!/usr/bin/env bash
# Compile all R3 test cases and run each through wizeng with the R3 monitor.
# Usage: ./run_all.sh [--release]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TESTS_DIR="$SCRIPT_DIR/tests"
WIZENG="/home/humzai/wizard-engine/bin/wizeng"
TARGET="wasm32-wasip1"
PROFILE="${1:-}"

if [[ "$PROFILE" == "--release" ]]; then
    BUILD_FLAG="--release"
    WASM_DIR="$TESTS_DIR/target/$TARGET/release"
else
    BUILD_FLAG=""
    WASM_DIR="$TESTS_DIR/target/$TARGET/debug"
fi

# ── Build ──────────────────────────────────────────────────────────────────
echo "=== Building (profile: ${BUILD_FLAG:-debug}) ==="
cd "$TESTS_DIR"
cargo build --target "$TARGET" $BUILD_FLAG 2>&1
echo

# ── Run each test ──────────────────────────────────────────────────────────
PASS=0; FAIL=0; TOTAL=0

for WASM in "$WASM_DIR"/tc*.wasm; do
    NAME="$(basename "$WASM" .wasm)"
    TOTAL=$((TOTAL + 1))

    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  $NAME"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    # Run wizeng; capture combined stdout+stderr
    OUTPUT="$("$WIZENG" --monitors="r3{exclude=host_*}" "$WASM" 2>&1)" && RC=0 || RC=$?

    if [[ $RC -eq 0 ]]; then
        echo "$OUTPUT"
        PASS=$((PASS + 1))
    else
        echo "[EXIT $RC]"
        echo "$OUTPUT"
        FAIL=$((FAIL + 1))
    fi
    echo
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Rust tests: $PASS/$TOTAL passed, $FAIL failed"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo

# ── wasm-r3-tests (copied from wizard-engine, exclude=r3*) ─────────────────
WASM_R3_DIR="$SCRIPT_DIR/wasm_r3_tests"
R3_PASS=0; R3_FAIL=0; R3_TOTAL=0

for WASM in "$WASM_R3_DIR"/*.wasm; do
    [[ "$(basename "$WASM")" == *.index.wasm ]] && continue
    NAME="$(basename "$WASM" .wasm)"
    R3_TOTAL=$((R3_TOTAL + 1))

    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  [wasm-r3] $NAME"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    OUTPUT="$("$WIZENG" --monitors="r3{exclude=r3*}" "$WASM" 2>&1)" && RC=0 || RC=$?

    if [[ $RC -eq 0 ]]; then
        echo "$OUTPUT"
        R3_PASS=$((R3_PASS + 1))
    else
        echo "[EXIT $RC]"
        echo "$OUTPUT"
        R3_FAIL=$((R3_FAIL + 1))
    fi
    echo
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  wasm-r3 tests: $R3_PASS/$R3_TOTAL passed, $R3_FAIL failed"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo
TOTAL_ALL=$((TOTAL + R3_TOTAL))
PASS_ALL=$((PASS + R3_PASS))
FAIL_ALL=$((FAIL + R3_FAIL))
echo "  GRAND TOTAL: $PASS_ALL/$TOTAL_ALL passed, $FAIL_ALL failed"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
