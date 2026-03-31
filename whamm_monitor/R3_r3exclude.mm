// R3_r3exclude.mm — R3 load event detection for wasm-r3-tests.
// r3* functions simulate the host; excluded from store/load tracking.

use r3_mem;

// ── Shadow memory initialization from data segments ─────────────────────
var data_len: u32 = active_data_len(APP_MEMID);
var data_start: u32 = active_data_start(APP_MEMID);
var ptr: i32 = r3_mem.mem_alloc(data_len as i32);
memcpy(APP_MEMID, data_start, memid(r3_mem), ptr as u32, data_len);

var shadow_inited: bool;

wasm:func:entry /!fname.starts_with("r3")/ {
    if (!shadow_inited) {
        shadow_inited = true;
        r3_mem.init_shadow(ptr, data_start as i32, data_len as i32);
    }
}

// ── Shadow updates: track every integer wasm store (non-host only) ────────

wasm:opcode:i32.store|i32.store8|i32.store16:before /!fname.starts_with("r3")/ {
    r3_mem.shadow_store(effective_addr as i32, data_size as i32, arg0 as i64);
}
wasm:opcode:i64.store|i64.store8|i64.store16|i64.store32:before /!fname.starts_with("r3")/ {
    r3_mem.shadow_store(effective_addr as i32, data_size as i32, arg0 as i64);
}

// ── Load event detection (non-host only) ─────────────────────────────────

wasm:opcode:i32.load|i32.load8_s|i32.load8_u|i32.load16_s|i32.load16_u:after /!fname.starts_with("r3")/ {
    r3_mem.check_load(effective_addr as i32, data_size as i32, res0 as i64);
}
wasm:opcode:i64.load|i64.load8_s|i64.load8_u|i64.load16_s|i64.load16_u|i64.load32_s|i64.load32_u:after /!fname.starts_with("r3")/ {
    r3_mem.check_load(effective_addr as i32, data_size as i32, res0 as i64);
}

wasm:report {
    r3_mem.print_trace();
}
