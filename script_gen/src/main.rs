use std::env;
use std::collections::HashMap;
use wasmparser::{Parser, Payload, Name, ValType, TypeRef, ExternalKind, CompositeInnerType, Operator};

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("Usage: script_gen <input.wasm> [--exclude <pattern>]");
        std::process::exit(1);
    }

    let input = &args[1];
    let exclude_pattern = args.iter()
        .position(|a| a == "--exclude")
        .and_then(|i| args.get(i + 1))
        .map(|s| s.as_str())
        .unwrap_or("r3*");

    let bytes = std::fs::read(input)
        .expect("failed to read input wasm");

    let info = parse_wasm(&bytes);
    let excluded = find_excluded(&info.func_names, exclude_pattern);

    emit_script(&info, &excluded);
}

// ── Wasm info ────────────────────────────────────────────────────────────

struct WasmInfo {
    func_names: HashMap<u32, String>,
    types: Vec<(Vec<ValType>, Vec<ValType>)>,
    num_imports: u32,
    import_type_indices: Vec<u32>,
    local_type_indices: Vec<u32>,
    exports: Vec<(String, u32)>,
    first_call_targets: HashMap<u32, u32>,  // local func fid → call target fid (if first instr is call)
}

impl WasmInfo {
    fn get_func_type(&self, func_index: u32) -> &(Vec<ValType>, Vec<ValType>) {
        let type_idx = if func_index < self.num_imports {
            self.import_type_indices[func_index as usize]
        } else {
            self.local_type_indices[(func_index - self.num_imports) as usize]
        };
        &self.types[type_idx as usize]
    }

    fn is_import(&self, func_index: u32) -> bool {
        func_index < self.num_imports
    }

    fn exported_fids(&self) -> Vec<u32> {
        self.exports.iter().map(|(_, fid)| *fid).collect()
    }
}

fn parse_wasm(bytes: &[u8]) -> WasmInfo {
    let mut info = WasmInfo {
        func_names: HashMap::new(),
        types: Vec::new(),
        num_imports: 0,
        import_type_indices: Vec::new(),
        local_type_indices: Vec::new(),
        exports: Vec::new(),
        first_call_targets: HashMap::new(),
    };

    let mut code_func_index: u32 = 0;  // tracks local function index in code section

    for payload in Parser::new(0).parse_all(bytes) {
        match payload {
            Ok(Payload::TypeSection(reader)) => {
                for rec_group in reader {
                    let rec_group = rec_group.expect("failed to parse type");
                    for sub_type in rec_group.into_types() {
                        match &sub_type.composite_type.inner {
                            CompositeInnerType::Func(func_type) => {
                                info.types.push((
                                    func_type.params().to_vec(),
                                    func_type.results().to_vec(),
                                ));
                            }
                            _ => {
                                info.types.push((Vec::new(), Vec::new()));
                            }
                        }
                    }
                }
            }
            Ok(Payload::ImportSection(reader)) => {
                for import in reader {
                    let import = import.expect("failed to parse import");
                    if let TypeRef::Func(type_idx) = import.ty {
                        info.import_type_indices.push(type_idx);
                        info.num_imports += 1;
                    }
                }
            }
            Ok(Payload::FunctionSection(reader)) => {
                for type_idx in reader {
                    let type_idx = type_idx.expect("failed to parse function");
                    info.local_type_indices.push(type_idx);
                }
            }
            Ok(Payload::ExportSection(reader)) => {
                for export in reader {
                    let export = export.expect("failed to parse export");
                    if export.kind == ExternalKind::Func {
                        info.exports.push((
                            export.name.to_string(),
                            export.index,
                        ));
                    }
                }
            }
            Ok(Payload::CustomSection(reader)) => {
                if let wasmparser::KnownCustom::Name(name_reader) = reader.as_known() {
                    for subsection in name_reader {
                        if let Ok(Name::Function(name_map)) = subsection {
                            for naming in name_map {
                                if let Ok(n) = naming {
                                    info.func_names.insert(
                                        n.index, n.name.to_string(),
                                    );
                                }
                            }
                        }
                    }
                }
            }
            Ok(Payload::CodeSectionEntry(body)) => {
                let fid = info.num_imports + code_func_index;
                if let Ok(mut ops) = body.get_operators_reader() {
                    if let Ok(first_op) = ops.read() {
                        if let Operator::Call { function_index } = first_op {
                            info.first_call_targets.insert(fid, function_index);
                        }
                    }
                }
                code_func_index += 1;
            }
            _ => {}
        }
    }

    info
}

// ── Exclusion ────────────────────────────────────────────────────────────

fn find_excluded(
    names: &HashMap<u32, String>,
    pattern: &str,
) -> Vec<u32> {
    let prefix = pattern.trim_end_matches('*');
    let mut ids: Vec<u32> = names.iter()
        .filter(|(_, name)| name.starts_with(prefix))
        .map(|(id, _)| *id)
        .collect();
    ids.sort();
    ids
}

fn make_exclude_predicate(excluded: &[u32]) -> String {
    if excluded.is_empty() {
        String::new()
    } else {
        let conds: Vec<String> = excluded.iter()
            .map(|id| format!("fid != {}", id))
            .collect();
        format!(" /{}/", conds.join(" && "))
    }
}

fn make_fid_predicate(fids: &[u32]) -> String {
    if fids.len() == 1 {
        format!("fid == {}", fids[0])
    } else {
        fids.iter()
            .map(|id| format!("fid == {}", id))
            .collect::<Vec<_>>()
            .join(" || ")
    }
}

fn make_imm0_predicate(fids: &[u32]) -> String {
    if fids.len() == 1 {
        format!("imm0 == {}", fids[0])
    } else {
        fids.iter()
            .map(|id| format!("imm0 == {}", id))
            .collect::<Vec<_>>()
            .join(" || ")
    }
}

// ── ValType helpers ──────────────────────────────────────────────────────

fn valtype_to_whamm(vt: &ValType) -> &'static str {
    match vt {
        ValType::I32 => "i32",
        ValType::I64 => "i64",
        ValType::F32 => "f32",
        ValType::F64 => "f64",
        _ => "i32",
    }
}

fn valtype_to_ec_fn(vt: &ValType) -> &'static str {
    match vt {
        ValType::I32 => "ec_param_i32",
        ValType::I64 => "ec_param_i64",
        ValType::F32 => "ec_param_f32",
        ValType::F64 => "ec_param_f64",
        _ => "ec_param_i32",
    }
}

fn valtype_to_ir_fn(vt: &ValType) -> &'static str {
    match vt {
        ValType::I32 => "ir_result_i32",
        ValType::I64 => "ir_result_i64",
        ValType::F32 => "ir_result_f32",
        ValType::F64 => "ir_result_f64",
        _ => "ir_result_i32",
    }
}

// ── Script emission ──────────────────────────────────────────────────────

fn emit_script(info: &WasmInfo, excluded: &[u32]) {
    let pred = make_exclude_predicate(excluded);

    // Preamble
    println!("// Auto-generated R3 monitor.");
    println!("// Excluded function IDs: {:?}", excluded);
    println!();
    println!("use r3_mem;");
    println!();

    // Shadow memory init (report var = fires once)
    println!("// ── Shadow memory init ───────────────────────────");
    println!("var data_len: u32 = active_data_len(APP_MEMID);");
    println!("var data_start: u32 = active_data_start(APP_MEMID);");
    println!("var ptr: i32 = r3_mem.mem_alloc(data_len as i32);");
    println!("memcpy(APP_MEMID, data_start, memid(r3_mem), ptr as u32, data_len);");
    println!("report var _shadow: i32 = r3_mem.init_shadow(ptr, data_start as i32, data_len as i32);");
    println!();

    // Name registration (report var = fires once per name)
    emit_name_registration(info);

    // call_depth variable
    println!("var call_depth: i32;");
    println!();

    // Per-function entry probes: EC check + call_depth increment
    // Returns fids that have combined EC+IC probes (collision workaround)
    let collision_fids = emit_entry_probes(info, excluded);

    // call_depth decrement on exit
    println!();
    println!("wasm:func:exit{} {{", pred);
    println!("    call_depth = call_depth - 1;");
    println!("}}");

    // IC probes (exclude collision fids to avoid double-firing)
    emit_ic_probes(excluded, &collision_fids);

    // IR probes
    emit_ir_probes(info, excluded);

    // Store/load probes
    emit_shadow_probes(&pred);

    // Report
    println!();
    println!("wasm:report {{");
    println!("    r3_mem.print_trace();");
    println!("}}");
}

fn emit_name_registration(info: &WasmInfo) {
    if info.exports.is_empty() {
        return;
    }
    println!("// ── Export name registration ─────────────────────");
    for (i, (export_name, func_index)) in info.exports.iter().enumerate() {
        // Escape backslashes and quotes in export name
        let escaped = export_name.replace('\\', "\\\\").replace('"', "\\\"");
        println!(
            "report var _n{}: str = \"{}\";",
            i, escaped
        );
        println!(
            "var _nl{}: u32 = _n{}.len();",
            i, i
        );
        println!(
            "var _np{}: i32 = r3_mem.mem_alloc(_nl{} as i32);",
            i, i
        );
        println!(
            "write_str(memid(r3_mem), _np{}, _n{});",
            i, i
        );
        println!(
            "report var _nr{}: i32 = r3_mem.register_name({} as i32, _np{}, _nl{} as i32);",
            i, func_index, i, i
        );
    }
    println!();
}

fn emit_entry_probes(info: &WasmInfo, excluded: &[u32]) -> Vec<u32> {
    // Collect exported fids (non-excluded, non-import)
    let mut export_fids: Vec<u32> = Vec::new();
    for (_, func_index) in &info.exports {
        if info.is_import(*func_index) { continue; }
        if excluded.contains(func_index) { continue; }
        if !export_fids.contains(func_index) {
            export_fids.push(*func_index);
        }
    }

    // Total non-excluded local function count
    let total_local = info.local_type_indices.len() as u32;
    let all_local_fids: Vec<u32> = (info.num_imports..info.num_imports + total_local)
        .filter(|fid| !excluded.contains(fid))
        .collect();

    // Detect collision: exported fids whose first instruction is call <excluded>
    let collision_fids: Vec<u32> = export_fids.iter()
        .filter(|&&fid| {
            info.first_call_targets.get(&fid)
                .map_or(false, |target| excluded.contains(target))
        })
        .copied()
        .collect();

    let imm0_pred = if !excluded.is_empty() {
        make_imm0_predicate(excluded)
    } else {
        String::new()
    };

    println!("// ── Per-function entry: EC + call_depth ──────────");

    // Exported functions: EC check + call_depth increment
    for &fid in &export_fids {
        let (params, _) = info.get_func_type(fid);
        let is_collision = collision_fids.contains(&fid);

        let ty_bounds = if params.is_empty() {
            String::new()
        } else {
            let binds: Vec<String> = params.iter().enumerate()
                .map(|(i, vt)| format!("local{}: {}", i, valtype_to_whamm(vt)))
                .collect();
            format!("({})", binds.join(", "))
        };

        if is_collision {
            // Combined EC+IC probe using opcode:call:before to avoid wildcard ordering bug
            println!(
                "wasm{}:opcode:call:before / opidx == 0 && fid == {} / {{",
                ty_bounds, fid
            );
        } else {
            println!(
                "wasm{}:opcode:*:before / opidx == 0 && fid == {} / {{",
                ty_bounds, fid
            );
        }
        println!("    if (call_depth == 0) {{");
        println!("        r3_mem.begin_ec(fid as i32);");
        for (i, vt) in params.iter().enumerate() {
            println!("        r3_mem.{}(local{});", valtype_to_ec_fn(vt), i);
        }
        println!("        r3_mem.end_ec();");
        println!("    }}");
        println!("    call_depth = call_depth + 1;");
        if is_collision {
            // Inline IC handling for the collision case
            println!("    if ({}) {{", imm0_pred);
            println!("        r3_mem.record_ic(imm0 as i32);");
            println!("        call_depth = call_depth - 1;");
            println!("    }}");
        }
        println!("}}");
    }

    // Non-exported, non-excluded functions: just call_depth increment
    let non_export_fids: Vec<u32> = all_local_fids.iter()
        .filter(|fid| !export_fids.contains(fid))
        .copied()
        .collect();

    if !non_export_fids.is_empty() {
        let pred = make_fid_predicate(&non_export_fids);
        println!(
            "wasm:opcode:*:before / opidx == 0 && ({}) / {{",
            pred
        );
        println!("    call_depth = call_depth + 1;");
        println!("}}");
    }

    collision_fids
}

fn emit_ic_probes(excluded: &[u32], collision_fids: &[u32]) {
    if excluded.is_empty() { return; }

    let target = make_imm0_predicate(excluded);
    // Exclude both excluded functions (they can't be callers) and collision fids
    // (IC is already handled in their combined EC+IC probe)
    let mut caller_excludes: Vec<String> = excluded.iter()
        .map(|id| format!("fid != {}", id))
        .collect();
    for &fid in collision_fids {
        caller_excludes.push(format!("fid != {}", fid));
    }

    println!();
    println!("// ── IC (Import Call) event detection ─────────────");
    println!(
        "wasm:opcode:call:before / ({}) && {} / {{",
        target, caller_excludes.join(" && "),
    );
    println!("    r3_mem.record_ic(imm0 as i32);");
    println!("    call_depth = call_depth - 1;");
    println!("}}");
}

fn emit_ir_probes(info: &WasmInfo, excluded: &[u32]) {
    if excluded.is_empty() { return; }

    let mut groups: HashMap<Vec<ValType>, Vec<u32>> = HashMap::new();
    for &fid in excluded {
        let (_, results) = info.get_func_type(fid);
        groups.entry(results.clone()).or_default().push(fid);
    }

    let caller: Vec<String> = excluded.iter()
        .map(|id| format!("fid != {}", id))
        .collect();
    let caller_str = caller.join(" && ");

    println!();
    println!("// ── IR (Import Return) event detection ───────────");

    let mut sorted: Vec<_> = groups.into_iter().collect();
    sorted.sort_by(|a, b| a.0.len().cmp(&b.0.len()).then_with(|| a.1.cmp(&b.1)));

    for (results, mut fids) in sorted {
        fids.sort();
        let target = make_imm0_predicate(&fids);

        let ty_bounds = if results.is_empty() {
            String::new()
        } else {
            let binds: Vec<String> = results.iter().enumerate()
                .map(|(i, vt)| format!("res{}: {}", i, valtype_to_whamm(vt)))
                .collect();
            format!("({})", binds.join(", "))
        };

        println!(
            "wasm:opcode:call{}:after / ({}) && {} / {{",
            ty_bounds, target, caller_str,
        );
        println!("    r3_mem.begin_ir(imm0 as i32);");
        for (i, vt) in results.iter().enumerate() {
            println!("    r3_mem.{}(res{});", valtype_to_ir_fn(vt), i);
        }
        println!("    r3_mem.end_ir();");
        println!("    call_depth = call_depth + 1;");
        println!("}}");
    }
}

fn emit_shadow_probes(pred: &str) {
    println!();
    println!("// ── Shadow store/load tracking ───────────────────");
    println!(
        "wasm:opcode:i32.store|i32.store8|i32.store16:before{} {{", pred
    );
    println!("    r3_mem.shadow_store(effective_addr as i32, data_size as i32, arg0 as i64);");
    println!("}}");
    println!(
        "wasm:opcode:i64.store|i64.store8|i64.store16|i64.store32:before{} {{", pred
    );
    println!("    r3_mem.shadow_store(effective_addr as i32, data_size as i32, arg0 as i64);");
    println!("}}");
    println!(
        "wasm:opcode:i32.load|i32.load8_s|i32.load8_u|i32.load16_s|i32.load16_u:after{} {{", pred
    );
    println!("    r3_mem.check_load(effective_addr as i32, data_size as i32, res0 as i64);");
    println!("}}");
    println!(
        "wasm:opcode:i64.load|i64.load8_s|i64.load8_u|i64.load16_s|i64.load16_u|i64.load32_s|i64.load32_u:after{} {{", pred
    );
    println!("    r3_mem.check_load(effective_addr as i32, data_size as i32, res0 as i64);");
    println!("}}");
}
