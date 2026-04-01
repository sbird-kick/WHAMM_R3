// Strip 1: removed shadow init, name registration, shadow probes
use r3_mem;

var call_depth: i32;

wasm(local0: i32, local1: i32):opcode:*:before / opidx == 0 && fid == 1 / {
    if (call_depth == 0) {
        r3_mem.begin_ec(fid as i32);
        r3_mem.ec_param_i32(local0);
        r3_mem.ec_param_i32(local1);
        r3_mem.end_ec();
    }
    call_depth = call_depth + 1;
}
wasm:opcode:*:before / opidx == 0 && fid == 2 / {
    if (call_depth == 0) {
        r3_mem.begin_ec(fid as i32);
        r3_mem.end_ec();
    }
    call_depth = call_depth + 1;
}

wasm:func:exit /fid != 0 && fid != 3/ {
    call_depth = call_depth - 1;
}

wasm:opcode:call:before / (imm0 == 0 || imm0 == 3) && fid != 0 && fid != 3 / {
    r3_mem.record_ic(imm0 as i32);
    call_depth = call_depth - 1;
}

wasm:opcode:call:after / (imm0 == 0 || imm0 == 3) && fid != 0 && fid != 3 / {
    r3_mem.begin_ir(imm0 as i32);
    r3_mem.end_ir();
    call_depth = call_depth + 1;
}

wasm:report {
    r3_mem.print_trace();
}
