// TC09: host_setup calls a non-host wasm helper. Because host_setup is excluded
// (no probes), the call to wasm_process is not tracked as IC. But wasm_process
// IS instrumented, so when it is entered while EXT is on the call stack it
// generates an EC event. Wasm_process reads memory written by host_setup.
// Expect: IC(host_setup) IR(host_setup)  with EC(wasm_process) inside the IC/IR?
// Actually: IC fires in main (before call to host_setup), IR fires in main
// (after host_setup returns). EC for wasm_process fires inside host_setup
// but is emitted to the trace at that point. So order in trace:
//   IC;host_setup  EC;wasm_process  IR;host_setup  L;...
static mut DATA: [i32; 4] = [0; 4];
static mut RESULT: i32 = 0;

// Non-host wasm function — will be called from inside host_setup.
// Gets EC event because EXT is on the call stack when it's entered.
#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn wasm_process() {
    // Reads data written by host_setup before this call.
    let mut s = 0i32;
    let mut i = 0usize;
    while i < 4 { s += DATA[i]; i += 1; } // Load events here
    RESULT = s;
}

#[no_mangle] #[inline(never)]
pub unsafe extern "C" fn host_setup() {
    DATA[0] = 1; DATA[1] = 2; DATA[2] = 3; DATA[3] = 4;
    wasm_process(); // host calls non-host wasm — EC fired, then wasm loads
}

fn main() {
    unsafe {
        host_setup(); // IC;host_setup ... IC;host_setup IR
    }
}
