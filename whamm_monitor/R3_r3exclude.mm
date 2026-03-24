// R3_r3exclude.mm — R3 trace for wasm-r3-tests (r3* functions simulate the host).
//
// Matches: wizeng --monitors=r3{exclude=r3*} app.wasm

use r3_mem;

var call_depth: i32;
var next_is_external: bool;

wasm:func:entry /!fname.starts_with("r3")/ {
    if (call_depth == 0 || next_is_external) {
        r3_mem.record_ec(fid as i32);
        next_is_external = false;
    }
    call_depth = call_depth + 1;
}

wasm:func:exit /!fname.starts_with("r3")/ {
    call_depth = call_depth - 1;
}

wasm:opcode:call:before /target_fn_type == "import"/ {
    next_is_external = true;
    r3_mem.record_ic(imm0 as i32);
}

// NOTE: wasm:opcode:call:after has a whamm codegen bug. IR events skipped.

wasm:opcode:i32.store|i32.store8|i32.store16:before /!fname.starts_with("r3")/ {
    r3_mem.shadow_store(effective_addr as i32, data_size as i32, arg0 as i64);
}
wasm:opcode:i64.store|i64.store8|i64.store16|i64.store32:before /!fname.starts_with("r3")/ {
    r3_mem.shadow_store(effective_addr as i32, data_size as i32, arg0 as i64);
}
wasm:opcode:i32.load|i32.load8_s|i32.load8_u|i32.load16_s|i32.load16_u:after /!fname.starts_with("r3")/ {
    r3_mem.check_load(effective_addr as i32, data_size as i32, res0 as i64);
}
wasm:opcode:i64.load|i64.load8_s|i64.load8_u|i64.load16_s|i64.load16_u|i64.load32_s|i64.load32_u:after /!fname.starts_with("r3")/ {
    r3_mem.check_load(effective_addr as i32, data_size as i32, res0 as i64);
}

wasm:report {
    r3_mem.print_trace();
}
