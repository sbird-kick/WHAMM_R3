use std::env;
use std::collections::HashMap;
use wasmparser::{Parser, Payload, Name, ValType, TypeRef, ExternalKind, CompositeInnerType};

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("Usage: script_gen <input.wasm> [--exclude <pattern>] [--exclude-imports]");
        std::process::exit(1);
    }
    let input = &args[1];
    let exclude = args.iter().position(|a| a == "--exclude")
        .and_then(|i| args.get(i + 1)).map(|s| s.as_str()).unwrap_or("r3*");
    let exclude_imports = args.iter().any(|a| a == "--exclude-imports");

    let bytes = std::fs::read(input).expect("failed to read input wasm");
    let info = parse_wasm(&bytes);
    let mut excluded = find_excluded(&info.func_names, exclude);
    if exclude_imports {
        for fid in 0..info.num_imports {
            if !excluded.contains(&fid) { excluded.push(fid); }
        }
        excluded.sort();
    }
    emit_script(&info, &excluded);
}

// ── Wasm info ────────────────────────────────────────────────────────────

struct GlobalInfo { idx: u32, valtype: ValType, mutable_: bool, init_i64: Option<i64> }

struct WasmInfo {
    func_names: HashMap<u32, String>,
    types: Vec<(Vec<ValType>, Vec<ValType>)>,
    num_imports: u32,
    import_type_indices: Vec<u32>,
    local_type_indices: Vec<u32>,
    exports: Vec<(String, u32)>,
    exported_globals: Vec<u32>,
    globals: Vec<GlobalInfo>,
}

impl WasmInfo {
    fn func_type(&self, fid: u32) -> &(Vec<ValType>, Vec<ValType>) {
        let ti = if fid < self.num_imports {
            self.import_type_indices[fid as usize]
        } else {
            self.local_type_indices[(fid - self.num_imports) as usize]
        };
        &self.types[ti as usize]
    }
    fn is_import(&self, fid: u32) -> bool { fid < self.num_imports }
}

fn parse_wasm(bytes: &[u8]) -> WasmInfo {
    let mut w = WasmInfo {
        func_names: HashMap::new(), types: Vec::new(), num_imports: 0,
        import_type_indices: Vec::new(), local_type_indices: Vec::new(), exports: Vec::new(), exported_globals: Vec::new(),
        globals: Vec::new(),
    };
    let mut num_imported_globals: u32 = 0;
    for payload in Parser::new(0).parse_all(bytes) {
        match payload {
            Ok(Payload::TypeSection(r)) => for rg in r {
                for st in rg.expect("type").into_types() {
                    match &st.composite_type.inner {
                        CompositeInnerType::Func(f) => w.types.push((f.params().to_vec(), f.results().to_vec())),
                        _ => w.types.push((Vec::new(), Vec::new())),
                    }
                }
            },
            Ok(Payload::ImportSection(r)) => for imp in r {
                let imp = imp.expect("import");
                match imp.ty {
                    TypeRef::Func(ti) => { w.import_type_indices.push(ti); w.num_imports += 1; }
                    TypeRef::Global(gt) => {
                        w.globals.push(GlobalInfo {
                            idx: num_imported_globals,
                            valtype: gt.content_type,
                            mutable_: gt.mutable,
                            init_i64: None,
                        });
                        num_imported_globals += 1;
                    }
                    _ => {}
                }
            },
            Ok(Payload::FunctionSection(r)) => for ti in r {
                w.local_type_indices.push(ti.expect("func"));
            },
            Ok(Payload::GlobalSection(r)) => for g in r {
                let g = g.expect("global");
                let idx = w.globals.len() as u32;
                // Extract init value from const expr
                let mut init_i64 = None;
                let mut ops = g.init_expr.get_operators_reader();
                if let Ok(op) = ops.read() {
                    init_i64 = match op {
                        wasmparser::Operator::I32Const { value } => Some(value as i64),
                        wasmparser::Operator::I64Const { value } => Some(value),
                        wasmparser::Operator::F32Const { value } =>
                            Some(f32::from_bits(value.bits()) .to_bits() as i64),
                        wasmparser::Operator::F64Const { value } =>
                            Some(f64::from_bits(value.bits()).to_bits() as i64),
                        _ => None,
                    };
                }
                w.globals.push(GlobalInfo { idx, valtype: g.ty.content_type, mutable_: g.ty.mutable, init_i64 });
            },
            Ok(Payload::ExportSection(r)) => for exp in r {
                let exp = exp.expect("export");
                match exp.kind {
                    ExternalKind::Func => w.exports.push((exp.name.into(), exp.index)),
                    ExternalKind::Global => w.exported_globals.push(exp.index),
                    _ => {}
                }
            },
            Ok(Payload::CustomSection(r)) => if let wasmparser::KnownCustom::Name(nr) = r.as_known() {
                for sub in nr { if let Ok(Name::Function(nm)) = sub {
                    for n in nm { if let Ok(n) = n { w.func_names.insert(n.index, n.name.into()); } }
                }}
            },
            _ => {}
        }
    }
    w
}

// ── Helpers ──────────────────────────────────────────────────────────────

fn find_excluded(names: &HashMap<u32, String>, pattern: &str) -> Vec<u32> {
    let pfx = pattern.trim_end_matches('*');
    let mut ids: Vec<u32> = names.iter().filter(|(_, n)| n.starts_with(pfx)).map(|(id, _)| *id).collect();
    ids.sort(); ids
}

fn pred(var: &str, fids: &[u32]) -> String {
    fids.iter().map(|id| format!("{} == {}", var, id)).collect::<Vec<_>>().join(" || ")
}

fn exclude_pred(excluded: &[u32]) -> String {
    if excluded.is_empty() { String::new() }
    else { format!(" /{}/", excluded.iter().map(|id| format!("fid != {}", id)).collect::<Vec<_>>().join(" && ")) }
}

fn vt(t: &ValType) -> &'static str {
    match t { ValType::I32=>"i32", ValType::I64=>"i64", ValType::F32=>"f32", ValType::F64=>"f64", _=>"i32" }
}

fn param_fn(t: &ValType) -> &'static str {
    match t { ValType::I32=>"param_i32", ValType::I64=>"param_i64", ValType::F32=>"param_f32", ValType::F64=>"param_f64", _=>"param_i32" }
}

fn ty_bounds_local(params: &[ValType]) -> String {
    if params.is_empty() { String::new() }
    else { format!("({})", params.iter().enumerate().map(|(i, t)| format!("local{}: {}", i, vt(t))).collect::<Vec<_>>().join(", ")) }
}

fn ty_bounds_res(results: &[ValType]) -> String {
    if results.is_empty() { String::new() }
    else { format!("({})", results.iter().enumerate().map(|(i, t)| format!("res{}: {}", i, vt(t))).collect::<Vec<_>>().join(", ")) }
}

/// Emit begin_event + param calls + end_event for EC (type=0) or IR (type=1).
/// `vars` are "local0", "local1"... or "res0", "res1"... with their types.
fn emit_event_body(event_type: i32, fid_expr: &str, vars: &[(&str, &ValType)], indent: &str) {
    println!("{}r3_mem.begin_event({}, {} as i32);", indent, fid_expr, event_type);
    for (name, t) in vars {
        println!("{}r3_mem.{}({});", indent, param_fn(t), name);
    }
    println!("{}r3_mem.end_event();", indent);
}

/// Group fids by return type signature.
fn group_by_results(info: &WasmInfo, fids: &[u32]) -> Vec<(Vec<ValType>, Vec<u32>)> {
    let mut groups: HashMap<Vec<ValType>, Vec<u32>> = HashMap::new();
    for &fid in fids { groups.entry(info.func_type(fid).1.clone()).or_default().push(fid); }
    let mut sorted: Vec<_> = groups.into_iter().collect();
    sorted.sort_by(|a, b| a.0.len().cmp(&b.0.len()).then_with(|| a.1.cmp(&b.1)));
    for (_, fids) in &mut sorted { fids.sort(); }
    sorted
}

// ── Script emission ──────────────────────────────────────────────────────

fn emit_script(info: &WasmInfo, excluded: &[u32]) {
    let epred = exclude_pred(excluded);

    println!("// Auto-generated R3 monitor.");
    println!("// Excluded function IDs: {:?}\n", excluded);
    println!("use r3_mem;\n");

    // Shadow init
    println!("var data_len: u32 = active_data_len(APP_MEMID);");
    println!("var data_start: u32 = active_data_start(APP_MEMID);");
    println!("var ptr: i32 = r3_mem.mem_alloc(data_len as i32);");
    println!("memcpy(APP_MEMID, data_start, memid(r3_mem), ptr as u32, data_len);");
    println!("report var _shadow: i32 = r3_mem.init_shadow(ptr, data_start as i32, data_len as i32);");

    // Shadow global init (non-zero initial values, exported globals only)
    for g in info.globals.iter().filter(|g| g.mutable_ && info.exported_globals.contains(&g.idx)) {
        if let Some(val) = g.init_i64 {
            if val != 0 {
                println!("var _gi{}: i32 = r3_mem.shadow_global_set({} as i32, {} as i64);",
                    g.idx, g.idx, val);
            }
        }
    }
    println!();

    // Name registration
    for (i, (name, fid)) in info.exports.iter().enumerate() {
        let esc = name.replace('\\', "\\\\").replace('"', "\\\"");
        println!("report var _n{i}: str = \"{esc}\";");
        println!("var _nl{i}: u32 = _n{i}.len();");
        println!("var _np{i}: i32 = r3_mem.mem_alloc(_nl{i} as i32);");
        println!("write_str(memid(r3_mem), _np{i}, _n{i});");
        println!("report var _nr{i}: i32 = r3_mem.register_name({fid} as i32, _np{i}, _nl{i} as i32);");
    }

    println!("\nvar call_depth: i32;");
    println!("var tracking_indirect: bool;");
    println!("var indirect_target_fid: i32 = -1;\n");

    // Per-function entry: EC + call_depth
    let export_fids: Vec<u32> = info.exports.iter()
        .map(|(_, fid)| *fid).filter(|fid| !info.is_import(*fid) && !excluded.contains(fid))
        .collect::<Vec<_>>().into_iter().collect::<std::collections::BTreeSet<_>>().into_iter().collect();

    for &fid in &export_fids {
        let (params, _) = info.func_type(fid);
        let vars: Vec<_> = params.iter().enumerate().map(|(i, t)| (format!("local{}", i), t)).collect();
        println!("wasm{}:opcode:*:before / opidx == 0 && fid == {} / {{", ty_bounds_local(params), fid);
        println!("    if (call_depth == 0) {{");
        emit_event_body(0, "fid as i32", &vars.iter().map(|(n, t)| (n.as_str(), *t)).collect::<Vec<_>>(), "        ");
        println!("    }}");
        println!("    call_depth = call_depth + 1;");
        println!("}}");
    }

    // Non-exported non-excluded: just call_depth
    let total = info.local_type_indices.len() as u32;
    let non_export: Vec<u32> = (info.num_imports..info.num_imports + total)
        .filter(|f| !excluded.contains(f) && !export_fids.contains(f)).collect();
    if !non_export.is_empty() {
        println!("wasm:opcode:*:before / opidx == 0 && ({}) / {{", pred("fid", &non_export));
        println!("    call_depth = call_depth + 1;");
        println!("}}");
    }

    // func:exit
    println!("\nwasm:func:exit{} {{", epred);
    println!("    call_depth = call_depth - 1;");
    println!("}}\n");

    // IC (direct call)
    if !excluded.is_empty() {
        println!("wasm:opcode:call:before / ({}) && {} / {{",
            pred("imm0", excluded),
            excluded.iter().map(|id| format!("fid != {}", id)).collect::<Vec<_>>().join(" && "));
        println!("    r3_mem.record_ic(imm0 as i32);");
        println!("    call_depth = call_depth - 1;");
        println!("}}\n");
    }

    // IR (direct call:after)
    if !excluded.is_empty() {
        let caller_pred = excluded.iter().map(|id| format!("fid != {}", id)).collect::<Vec<_>>().join(" && ");
        for (results, fids) in group_by_results(info, excluded) {
            let vars: Vec<_> = results.iter().enumerate().map(|(i, t)| (format!("res{}", i), t)).collect();
            println!("wasm:opcode:call{}:after / ({}) && {} / {{",
                ty_bounds_res(&results), pred("imm0", &fids), caller_pred);
            emit_event_body(1, "imm0 as i32", &vars.iter().map(|(n, t)| (n.as_str(), *t)).collect::<Vec<_>>(), "    ");
            println!("    call_depth = call_depth + 1;");
            println!("}}\n");
        }
    }

    // call_indirect IC/IR
    if !excluded.is_empty() {
        println!("wasm:opcode:call_indirect:before {{");
        println!("    tracking_indirect = true;");
        println!("}}");

        println!("wasm:func:entry / {} / {{", pred("fid", excluded));
        println!("    if (tracking_indirect) {{");
        println!("        r3_mem.record_ic(fid as i32);");
        println!("        indirect_target_fid = fid as i32;");
        println!("        call_depth = call_depth - 1;");
        println!("        tracking_indirect = false;");
        println!("    }}");
        println!("}}");

        println!("wasm:func:entry / {} / {{",
            excluded.iter().map(|id| format!("fid != {}", id)).collect::<Vec<_>>().join(" && "));
        println!("    if (tracking_indirect) {{");
        println!("        tracking_indirect = false;");
        println!("        indirect_target_fid = -1;");
        println!("    }}");
        println!("}}\n");

        // call_indirect:after — typed first, void last
        let groups = group_by_results(info, excluded);
        let mut void_group = false;
        for (results, _) in &groups {
            if results.is_empty() { void_group = true; continue; }
            let vars: Vec<_> = results.iter().enumerate().map(|(i, t)| (format!("res{}", i), t)).collect();
            println!("wasm:opcode:call_indirect{}:after {{", ty_bounds_res(results));
            println!("    if (indirect_target_fid != -1) {{");
            emit_event_body(1, "indirect_target_fid", &vars.iter().map(|(n, t)| (n.as_str(), *t)).collect::<Vec<_>>(), "        ");
            println!("        call_depth = call_depth + 1;");
            println!("        indirect_target_fid = -1;");
            println!("    }}");
            println!("}}");
        }
        if void_group {
            println!("wasm:opcode:call_indirect:after {{");
            println!("    if (indirect_target_fid != -1) {{");
            emit_event_body(1, "indirect_target_fid", &[], "        ");
            println!("        call_depth = call_depth + 1;");
            println!("        indirect_target_fid = -1;");
            println!("    }}");
            println!("}}");
        }
    }

    // Global shadow (G events)
    emit_global_probes(info, excluded);

    // Bulk memory shadow updates
    println!("\nwasm:opcode:memory.grow:after{epred} {{");
    println!("    r3_mem.shadow_grow(res0, arg0 as i32);");
    println!("}}");
    // memory.fill stack: dest, val, len → arg2=dest, arg1=val, arg0=len
    println!("wasm:opcode:memory.fill:before{epred} {{");
    println!("    r3_mem.shadow_fill(arg2 as i32, arg1 as i32, arg0 as i32);");
    println!("}}");
    // memory.copy stack: dest, src, len → arg2=dest, arg1=src, arg0=len
    println!("wasm:opcode:memory.copy:before{epred} {{");
    println!("    r3_mem.shadow_copy(arg2 as i32, arg1 as i32, arg0 as i32);");
    println!("}}");

    // Shadow store/load
    println!("\nwasm:opcode:i32.store|i32.store8|i32.store16:before{epred} {{");
    println!("    r3_mem.shadow_store(effective_addr as i32, data_size as i32, arg0 as i64);");
    println!("}}");
    println!("wasm:opcode:i64.store|i64.store8|i64.store16|i64.store32:before{epred} {{");
    println!("    r3_mem.shadow_store(effective_addr as i32, data_size as i32, arg0 as i64);");
    println!("}}");
    println!("wasm:opcode:i32.load|i32.load8_s|i32.load8_u|i32.load16_s|i32.load16_u:after{epred} {{");
    println!("    r3_mem.check_load(effective_addr as i32, data_size as i32, res0 as i64);");
    println!("}}");
    println!("wasm:opcode:i64.load|i64.load8_s|i64.load8_u|i64.load16_s|i64.load16_u|i64.load32_s|i64.load32_u:after{epred} {{");
    println!("    r3_mem.check_load(effective_addr as i32, data_size as i32, res0 as i64);");
    println!("}}\n");

    println!("wasm:report {{");
    println!("    r3_mem.print_trace();");
    println!("}}");
}

fn emit_global_probes(info: &WasmInfo, excluded: &[u32]) {
    let mut_globals: Vec<&GlobalInfo> = info.globals.iter()
        .filter(|g| g.mutable_ && info.exported_globals.contains(&g.idx))
        .collect();
    if mut_globals.is_empty() { return; }

    // Group mutable globals by type
    let mut by_type: HashMap<ValType, Vec<u32>> = HashMap::new();
    for g in &mut_globals {
        by_type.entry(g.valtype).or_default().push(g.idx);
    }

    println!("\n// ── G (Global) event detection ───────────────────");

    for (valtype, idxs) in &by_type {
        let idx_pred = pred("imm0", idxs);
        let t = vt(valtype);
        let check_fn = match valtype {
            ValType::I32 => "check_global_i32",
            ValType::I64 => "check_global_i64",
            ValType::F32 => "check_global_f32",
            ValType::F64 => "check_global_f64",
            _ => "check_global_i32",
        };

        // Combined predicate: exclude + index filter
        let full_pred = if excluded.is_empty() {
            format!(" / {} /", idx_pred)
        } else {
            let excl = excluded.iter().map(|id| format!("fid != {}", id)).collect::<Vec<_>>().join(" && ");
            format!(" / {} && ({}) /", excl, idx_pred)
        };

        // global.set:before — update shadow (dummy var workaround for whamm bug)
        println!("wasm:opcode:global.set(arg0: {}):before{} {{", t, full_pred);
        println!("    var _d: i32 = r3_mem.shadow_global_set(imm0 as i32, arg0 as i64);");
        println!("}}");

        // global.get:after — compare and emit G on mismatch
        println!("wasm:opcode:global.get(res0: {}):after{} {{", t, full_pred);
        println!("    r3_mem.{}(imm0 as i32, res0);", check_fn);
        println!("}}");
    }
}
