#!/usr/bin/env bash
# Reproducible build for the db_* SQLite/compression differential tests.
# See db_BUILD.txt for the exact fetch commands that populate $DB_SRC.
set -euo pipefail

DB_SRC="${DB_SRC:-/Users/humza/.claude/jobs/33c02e0d/tmp/db_src}"
CC="${CC:-/Users/humza/Downloads/claude-play-space/wasi-sdk/bin/clang}"
MZ="$DB_SRC/miniz-3.0.2"
SQ="$DB_SRC/sqlite-amalgamation-3460100"
HERE="$(cd "$(dirname "$0")" && pwd)"
cd "$HERE"

MZDEFS=(-DMINIZ_NO_STDIO -DMINIZ_NO_TIME -DMINIZ_NO_ARCHIVE_APIS)
COMMON=(-Oz "${MZDEFS[@]}" -ffunction-sections -fdata-sections -Wl,--gc-sections -I "$MZ")

mz() { # name [extra flags...]
  local n="$1"; shift
  "$CC" "${COMMON[@]}" "$@" "$n.c" "$MZ/miniz.c" -o "$n.wasm"
  echo "built $n.wasm ($(wc -c < "$n.wasm") bytes)"
}

mz db_zlib_roundtrip_01
mz db_zlib_pseudorandom_02
mz db_zlib_incompressible_03
mz db_zlib_levels_04
mz db_zlib_decompress_05 -DMINIZ_NO_DEFLATE_APIS
mz db_zlib_rawdeflate_06 -DMINIZ_NO_DEFLATE_APIS
mz db_zlib_checksums_07
mz db_zlib_multibuf_08

# SQLite (currently classified failing: whamm instr stack-overflows on it).
# Build recipe kept for reproducibility of the whamm-bug repro.
SQDEFS=(-DSQLITE_THREADSAFE=0 -DSQLITE_OMIT_LOAD_EXTENSION -DSQLITE_DEFAULT_MEMSTATUS=0 \
        -DSQLITE_DQS=0 -DSQLITE_TEMP_STORE=3 -DSQLITE_OMIT_DEPRECATED)
sqlite_build() { # src.c out.wasm
  "$CC" -Oz "${SQDEFS[@]}" -ffunction-sections -fdata-sections -Wl,--gc-sections \
        -I "$SQ" "$1" "$SQ/sqlite3.c" -o "$2"
  echo "built $2 ($(wc -c < "$2") bytes)"
}
# sqlite_build ../gen_candidates/failing/db_sqlite_basic_01.c ../gen_candidates/failing/db_sqlite_basic_01.wasm
