// R3.mm — whamm implementation of R3 trace (EC, IC, IR, L events).
//
// Matches: wizeng --monitors=r3{exclude=host_*} app.wasm
//
// In tc* test cases, host_* functions are LOCAL wasm functions (not imports)
// that simulate the host boundary. IC/IR events use target_fn_name.starts_with.
//
// EC detection:
//   - call_depth == 0 → direct top-level entry from outside wasm
//   - next_is_external → wasm just called a host_* function; the host re-entered

use r3_mem;

var call_depth: i32;
var next_is_external: bool;

// ── External call detection ───────────────────────────────────────────────

wasm:func:entry /!fname.starts_with("host_")/ {
    if (call_depth == 0 || next_is_external) {
        r3_mem.record_ec(fid as i32);
        next_is_external = false;
    }
    call_depth = call_depth + 1;
}

wasm:func:exit /!fname.starts_with("host_")/ {
    call_depth = call_depth - 1;
}

// ── Import call / return (host boundary) ─────────────────────────────────
// host_* are local wasm functions simulating the host; treat calls to them
// as IC events and set next_is_external so re-entries are detected as EC.

wasm:opcode:call:before /target_fn_name.starts_with("host_")/ {
    next_is_external = true;
    r3_mem.record_ic(imm0 as i32);
}

// NOTE: wasm:opcode:call:after has a whamm codegen bug (local.get beyond
// declared locals for void-returning calls). IR events are skipped for now.

// ── Shadow updates: track every integer wasm store (non-host only) ────────

wasm:opcode:i32.store|i32.store8|i32.store16:before /!fname.starts_with("host_")/ {
    r3_mem.shadow_store(effective_addr as i32, data_size as i32, arg0 as i64);
}

wasm:opcode:i64.store|i64.store8|i64.store16|i64.store32:before /!fname.starts_with("host_")/ {
    r3_mem.shadow_store(effective_addr as i32, data_size as i32, arg0 as i64);
}

// ── Load event detection (non-host only) ─────────────────────────────────

wasm:opcode:i32.load|i32.load8_s|i32.load8_u|i32.load16_s|i32.load16_u:after /!fname.starts_with("host_")/ {
    r3_mem.check_load(effective_addr as i32, data_size as i32, res0 as i64);
}

wasm:opcode:i64.load|i64.load8_s|i64.load8_u|i64.load16_s|i64.load16_u|i64.load32_s|i64.load32_u:after /!fname.starts_with("host_")/ {
    r3_mem.check_load(effective_addr as i32, data_size as i32, res0 as i64);
}

// ── Flush trace ───────────────────────────────────────────────────────────

wasm:report {
    r3_mem.print_trace();
}
