#!/usr/bin/env bash
# Parallel test of all o8_ wasms. 5-way. Output to /tmp/o8_results.txt
cd /Users/humza/Downloads/claude-play-space/WHAMM_R3
: > /tmp/o8_results.txt
run_one(){ ./test_c.sh "$1" 2>/dev/null >> /tmp/o8_results.txt; }
export -f run_one
ls gen_tests_native/o8_*.wasm | xargs -P 5 -I{} bash -c 'run_one "$@"' _ {}
echo "ALLDONE $(wc -l < /tmp/o8_results.txt)"
sort /tmp/o8_results.txt | awk '{print $1}' | sort | uniq -c
