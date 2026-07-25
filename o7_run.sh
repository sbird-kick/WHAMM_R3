#!/usr/bin/env bash
# Run harness over o7 tests with limited parallelism; collect results.
cd /Users/humza/Downloads/claude-play-space/WHAMM_R3
RES=/tmp/o7_results.txt
: > "$RES"
run_one(){
  local w="$1"
  local out
  out=$(./test_c.sh "$w" 2>/dev/null)
  echo "$out" >> /tmp/o7_results.txt
}
export -f run_one
ls gen_tests_native/o7_*.wasm | xargs -P 4 -I{} bash -c 'run_one "$@"' _ {}
echo "=== SUMMARY ==="
sort "$RES" | awk '{print $1}' | sort | uniq -c
echo "=== NON-PASS ==="
grep -vE '^PASS' "$RES" | sort
