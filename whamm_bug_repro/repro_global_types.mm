use tiny_lib;

wasm:opcode:global.set(arg0: i32):before / imm0 == 1 / {
    var _dummy: i32 = tiny_lib.take_i64(arg0 as i64);
}
