#!/usr/bin/env bash
# Build + test all o5_ wat files not yet having a .wasm result recorded.
cd /Users/humza/Downloads/claude-play-space/WHAMM_R3
for wat in "$@"; do
  name=$(basename "$wat" .wat)
  flags=""
  # multi-memory needs flag
  if grep -qE '\(memory[^)]*\)[[:space:]]*\(memory' "$wat" 2>/dev/null; then flags="--enable-multi-memory"; fi
  # count memory decls
  nmem=$(grep -cE '^\s*\(memory' "$wat")
  if [ "$nmem" -gt 1 ]; then flags="--enable-multi-memory"; fi
  if ! wat2wasm --debug-names $flags "gen_tests/$name.wat" -o "gen_tests/$name.wasm" 2>/tmp/o5_wat_$name.err; then
    echo "WAT_FAIL $name :: $(head -1 /tmp/o5_wat_$name.err)"
    continue
  fi
  res=$(./test_one.sh "gen_tests/$name.wasm" 2>&1)
  echo "$res"
done
