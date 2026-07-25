#!/usr/bin/env bash
# Build + test all o8_ cpp tests not yet compiled. Arg optional: glob suffix.
CLANG=/Users/humza/Downloads/claude-play-space/wasi-sdk/bin/clang++
cd /Users/humza/Downloads/claude-play-space/WHAMM_R3
for src in gen_tests_native/o8_*.cpp; do
  [ -e "$src" ] || continue
  wasm="${src%.cpp}.wasm"
  name=$(basename "$src" .cpp)
  if [ ! -f "$wasm" ] || [ "$src" -nt "$wasm" ]; then
    if ! $CLANG -O1 -fno-exceptions -fno-rtti "$src" -o "$wasm" 2>/tmp/o8_cc_$name.err; then
      echo "CCFAIL $name"; continue
    fi
  fi
  res=$(./test_c.sh "$wasm" 2>/dev/null)
  echo "$res"
done
