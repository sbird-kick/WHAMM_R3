#!/usr/bin/env bash
# Run the full R3 test suite:
#   - wasm-r3 (99 single-module, --exclude "r3")
#   - IG (5 multi-module)
#   - C/C++ (9 single-module, --exclude-imports)
# Usage: ./run_tests.sh [-j N]   (default: 6 parallel workers — leave 2 of the
# 8 cores free on this laptop)
set -u

JOBS=6
while getopts "j:" opt; do
    case $opt in j) JOBS="$OPTARG";; *) echo "Usage: $0 [-j N]"; exit 1;; esac
done

RESULTS=$(mktemp)
trap 'rm -f "$RESULTS"' EXIT

echo "Running wasm-r3 tests (parallel=$JOBS)..."
ls wasm_r3_tests/*.wasm 2>/dev/null | grep -v '\.index\.wasm$' \
    | xargs -P "$JOBS" -I{} ./test_one.sh {} >> "$RESULTS" 2>/dev/null

echo "Running generated tests (parallel=$JOBS)..."
ls gen_tests/*.wasm 2>/dev/null \
    | xargs -P "$JOBS" -I{} ./test_one.sh {} >> "$RESULTS" 2>/dev/null

echo "Running IG tests..."
for f in ig_tests/ig_basic.wasm ig_tests/ig_multi_type.wasm ig_tests/ig_zero.wasm \
         ig_tests/ig_with_calls.wasm ig_tests/ig_mutable.wasm; do
    [ -f "$f" ] && ./test_ig.sh "$f" >> "$RESULTS" 2>/dev/null
done

echo "Running C/C++ tests (parallel=$JOBS)..."
# complex and fibonacci crash wizard's oracle — skip them
ls c_tests/*.wasm 2>/dev/null | grep -v 'complex\|fibonacci' \
    | xargs -P "$JOBS" -I{} ./test_c.sh {} >> "$RESULTS" 2>/dev/null

# Summary
TOTAL=$(wc -l < "$RESULTS")
PASS=$(grep -c '^PASS' "$RESULTS" || true)
ORDER=$(grep -c '^ORDER' "$RESULTS" || true)
FAIL=$(grep -c '^FAIL' "$RESULTS" || true)

echo ""
sort "$RESULTS"
echo ""
echo "Total: $TOTAL  PASS: $PASS  ORDER: $ORDER  FAIL: $FAIL"

[ "$FAIL" -eq 0 ] && [ "$ORDER" -eq 0 ] && exit 0 || exit 1
