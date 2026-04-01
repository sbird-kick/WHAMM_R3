// BUG: Two opcode:*:before probes — one with localN type bounds, one without.
// The probe WITHOUT type bounds silently stops firing.
//
// Expected output:
//   probe_A fired for fid=0
//   probe_B fired for fid=1
//
// Actual output:
//   probe_A fired for fid=0
//
// Workaround: remove "(local0: i32, local1: i32)" from probe A → both fire.

use r3_mem;

// Probe A: has localN type bounds
wasm(local0: i32, local1: i32):opcode:*:before / opidx == 0 && fid == 0 / {
    r3_mem.record_ic(0 as i32);
}

// Probe B: no type bounds — SUPPRESSED by probe A
wasm:opcode:*:before / opidx == 0 && fid == 1 / {
    r3_mem.record_ic(1 as i32);
}

wasm:report {
    r3_mem.print_trace();
}
