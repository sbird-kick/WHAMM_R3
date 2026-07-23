use std::env;
use std::collections::{HashMap, BTreeSet};
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

// ── Wasm parsing ─────────────────────────────────────────────────────────

struct GlobalInfo { idx: u32, valtype: ValType, mutable_: bool, init_i64: Option<i64> }

struct WasmInfo {
    func_names: HashMap<u32, String>,
    types: Vec<(Vec<ValType>, Vec<ValType>)>,
    num_imports: u32,
    num_imported_globals: u32,
    import_type_indices: Vec<u32>,
    local_type_indices: Vec<u32>,
    exports: Vec<(String, u32)>,
    exported_globals: Vec<u32>,
    globals: Vec<GlobalInfo>,
    passive_segments: Vec<(u32, Vec<u8>)>,        // (segidx, bytes)
    active_nonzero_segments: Vec<(u32, u64, Vec<u8>)>, // (memidx, offset, bytes) for memidx != 0
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
        func_names: HashMap::new(), types: Vec::new(), num_imports: 0, num_imported_globals: 0,
        import_type_indices: Vec::new(), local_type_indices: Vec::new(),
        exports: Vec::new(), exported_globals: Vec::new(), globals: Vec::new(),
        passive_segments: Vec::new(), active_nonzero_segments: Vec::new(),
    };
    let mut seg_idx: u32 = 0;
    for payload in Parser::new(0).parse_all(bytes) {
        match payload {
            Ok(Payload::DataSection(r)) => for d in r {
                let d = d.expect("data segment");
                match d.kind {
                    wasmparser::DataKind::Passive => w.passive_segments.push((seg_idx, d.data.to_vec())),
                    wasmparser::DataKind::Active { memory_index, offset_expr } => {
                        if memory_index != 0 {
                            // Shadow for memory != 0 isn't seeded by whamm's active_data_*
                            // bound fns (they cover memory 0); register bytes explicitly.
                            if let Ok(wasmparser::Operator::I32Const { value }) = offset_expr.get_operators_reader().read() {
                                w.active_nonzero_segments.push((memory_index, value as u32 as u64, d.data.to_vec()));
                            }
                        }
                    }
                }
                seg_idx += 1;
            },
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
                        w.globals.push(GlobalInfo { idx: w.num_imported_globals, valtype: gt.content_type, mutable_: gt.mutable, init_i64: None });
                        w.num_imported_globals += 1;
                    }
                    _ => {}
                }
            },
            Ok(Payload::FunctionSection(r)) => for ti in r { w.local_type_indices.push(ti.expect("func")); },
            Ok(Payload::GlobalSection(r)) => for g in r {
                let g = g.expect("global");
                let idx = w.globals.len() as u32;
                let mut init_i64 = None;
                if let Ok(op) = g.init_expr.get_operators_reader().read() {
                    init_i64 = match op {
                        wasmparser::Operator::I32Const { value } => Some(value as i64),
                        wasmparser::Operator::I64Const { value } => Some(value),
                        wasmparser::Operator::F32Const { value } => Some(f32::from_bits(value.bits()).to_bits() as i64),
                        wasmparser::Operator::F64Const { value } => Some(f64::from_bits(value.bits()).to_bits() as i64),
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

fn find_excluded(names: &HashMap<u32, String>, pattern: &str) -> Vec<u32> {
    let pfx = pattern.trim_end_matches('*');
    let mut ids: Vec<u32> = names.iter().filter(|(_, n)| n.starts_with(pfx)).map(|(id, _)| *id).collect();
    ids.sort(); ids
}

// ── Predicate helpers ────────────────────────────────────────────────────

fn eq_pred(var: &str, fids: &[u32]) -> String {
    fids.iter().map(|id| format!("{var} == {id}")).collect::<Vec<_>>().join(" || ")
}

fn neq_pred(fids: &[u32]) -> String {
    fids.iter().map(|id| format!("fid != {id}")).collect::<Vec<_>>().join(" && ")
}

fn exclude_pred(excluded: &[u32]) -> String {
    if excluded.is_empty() { String::new() } else { format!(" /{}/", neq_pred(excluded)) }
}

// ── ValType helpers ──────────────────────────────────────────────────────

fn vt(t: &ValType) -> &'static str {
    match t { ValType::I32=>"i32", ValType::I64=>"i64", ValType::F32=>"f32", ValType::F64=>"f64", _=>"i32" }
}

fn pfn(t: &ValType) -> &'static str {
    match t { ValType::I32=>"param_i32", ValType::I64=>"param_i64", ValType::F32=>"param_f32", ValType::F64=>"param_f64", _=>"param_i32" }
}

fn ty_bounds(prefix: &str, types: &[ValType]) -> String {
    if types.is_empty() { String::new() }
    else { format!("({})", types.iter().enumerate().map(|(i, t)| format!("{prefix}{i}: {}", vt(t))).collect::<Vec<_>>().join(", ")) }
}

/// Group fids by a component of their type signature (params or results).
fn group_by_sig(info: &WasmInfo, fids: &[u32], sel: fn(&(Vec<ValType>, Vec<ValType>)) -> &Vec<ValType>) -> Vec<(Vec<ValType>, Vec<u32>)> {
    let mut groups: HashMap<Vec<ValType>, Vec<u32>> = HashMap::new();
    for &fid in fids { groups.entry(sel(info.func_type(fid)).clone()).or_default().push(fid); }
    let mut sorted: Vec<_> = groups.into_iter().collect();
    sorted.sort_by(|a, b| a.0.len().cmp(&b.0.len()).then_with(|| a.1.cmp(&b.1)));
    for (_, fids) in &mut sorted { fids.sort(); }
    sorted
}

fn group_by_results(info: &WasmInfo, fids: &[u32]) -> Vec<(Vec<ValType>, Vec<u32>)> {
    group_by_sig(info, fids, |t| &t.1)
}

// ── Event body emission ──────────────────────────────────────────────────

fn emit_event(event_type: i32, fid_expr: &str, prefix: &str, types: &[ValType], indent: &str) {
    println!("{indent}r3_mem.begin_event({fid_expr}, {event_type} as i32);");
    for (i, t) in types.iter().enumerate() { println!("{indent}r3_mem.{}({prefix}{i});", pfn(t)); }
    println!("{indent}r3_mem.end_event();");
}

// ── Script emission ──────────────────────────────────────────────────────

fn emit_script(info: &WasmInfo, excluded: &[u32]) {
    let epred = exclude_pred(excluded);
    let npred = neq_pred(excluded);

    // Preamble
    println!("// Auto-generated R3 monitor.\n// Excluded: {:?}\n\nuse r3_mem;\n", excluded);

    emit_preamble(info);
    emit_ig_probes(info);
    emit_entry_probes(info, excluded);
    emit_direct_call_probes(info, excluded, &npred);
    emit_indirect_call_probes(info, excluded, &npred);
    emit_global_probes(info, excluded);
    emit_shadow_probes(&epred);

    println!("\nwasm:report {{\n    r3_mem.print_trace();\n}}");
}

/// Bytes → little-endian i64 chunks: (offset, chunk_value, chunk_len).
fn i64_chunks(bytes: &[u8]) -> Vec<(usize, i64, usize)> {
    bytes.chunks(8).enumerate().map(|(i, c)| {
        let mut v: i64 = 0;
        for (j, b) in c.iter().enumerate() { v |= (*b as i64) << (j * 8); }
        (i * 8, v, c.len())
    }).collect()
}

const MAX_REGISTERED_SEGMENT_BYTES: usize = 65536;

fn emit_preamble(info: &WasmInfo) {
    // Shadow memory init
    println!("var data_len: u32 = active_data_len(APP_MEMID);");
    println!("var data_start: u32 = active_data_start(APP_MEMID);");
    println!("var ptr: i32 = r3_mem.mem_alloc(data_len as i32);");
    println!("memcpy(APP_MEMID, data_start, memid(r3_mem), ptr as u32, data_len);");
    println!("@init r3_mem.init_shadow(ptr, data_start as i32, data_len as i32);");

    // Passive data segments: register bytes so memory.init can update the shadow.
    let total: usize = info.passive_segments.iter().map(|(_, b)| b.len()).sum();
    if total > MAX_REGISTERED_SEGMENT_BYTES {
        eprintln!("warning: {total} bytes of passive data segments exceed the {MAX_REGISTERED_SEGMENT_BYTES}-byte \
                   registration cap — skipping; memory.init tracking will be incomplete (false L events possible)");
    } else {
        for (segidx, bytes) in &info.passive_segments {
            for (off, chunk, len) in i64_chunks(bytes) {
                println!("@init r3_mem.passive_chunk({segidx} as i32, {off} as i32, {chunk} as i64, {len} as i32);");
            }
        }
    }

    // Active data segments for memory != 0: seed those shadows directly.
    for (memidx, offset, bytes) in &info.active_nonzero_segments {
        for (off, chunk, len) in i64_chunks(bytes) {
            println!("@init r3_mem.shadow_store({memidx} as i32, {} as i32, {len} as i32, {chunk} as i64);", *offset as usize + off);
        }
    }

    // Shadow global init (exported mutable globals with non-zero init)
    for g in info.globals.iter().filter(|g| g.mutable_ && info.exported_globals.contains(&g.idx)) {
        if let Some(val) = g.init_i64 {
            if val != 0 { println!("r3_mem.shadow_global_set({} as i32, {} as i64);", g.idx, val); }
        }
    }

    // Export name registration
    for (i, (name, fid)) in info.exports.iter().enumerate() {
        let esc = name.replace('\\', "\\\\").replace('"', "\\\"");
        println!("var _n{i}: str = \"{esc}\";");
        println!("var _nl{i}: u32 = _n{i}.len();");
        println!("var _np{i}: i32 = r3_mem.mem_alloc(_nl{i} as i32);");
        println!("write_str(memid(r3_mem), _np{i}, _n{i});");
        println!("@init r3_mem.register_name({fid} as i32, _np{i}, _nl{i} as i32);");
    }

    println!("\nvar call_depth: i32;");
    println!("var tracking_indirect: bool;");
    println!("var indirect_target_fid: i32 = -1;\n");
}

fn ig_fn(t: &ValType) -> &'static str {
    match t { ValType::I32=>"record_ig_i32", ValType::I64=>"record_ig_i64",
              ValType::F32=>"record_ig_f32", ValType::F64=>"record_ig_f64", _=>"record_ig_i32" }
}

fn check_fn(t: &ValType) -> &'static str {
    match t { ValType::I32=>"check_global_i32", ValType::I64=>"check_global_i64",
              ValType::F32=>"check_global_f32", ValType::F64=>"check_global_f64", _=>"check_global_i32" }
}

fn emit_ig_probes(info: &WasmInfo) {
    let imported: Vec<&GlobalInfo> = info.globals.iter()
        .filter(|g| g.idx < info.num_imported_globals).collect();
    if imported.is_empty() { return; }

    println!("// ── IG (ImportedGlobal) events ────────────────────");
    for g in &imported {
        let (t, idx) = (vt(&g.valtype), g.idx);
        println!("var ig_done_{idx}: bool;");
        println!("wasm:opcode:global.get(res0: {t}):after / imm0 == {idx} && !ig_done_{idx} / {{");
        println!("    ig_done_{idx} = true;");
        println!("    r3_mem.{}({idx} as i32, res0);", ig_fn(&g.valtype));
        println!("    r3_mem.shadow_global_set({idx} as i32, res0 as i64);\n}}\n");
    }
}

fn emit_entry_probes(info: &WasmInfo, excluded: &[u32]) {
    let export_fids: Vec<u32> = info.exports.iter()
        .map(|(_, fid)| *fid).filter(|fid| !info.is_import(*fid) && !excluded.contains(fid))
        .collect::<BTreeSet<_>>().into_iter().collect();

    // Exported: EC check + call_depth, grouped by param signature.
    // (Historically one probe per function — whamm <1.0 didn't respect script order
    // with >2 probes on one event. Retested grouped on v1.0.0: order is respected.)
    for (params, fids) in group_by_sig(info, &export_fids, |t| &t.0) {
        println!("wasm{}:opcode:*:before / opidx == 0 && ({}) / {{", ty_bounds("local", &params), eq_pred("fid", &fids));
        println!("    if (call_depth == 0) {{");
        emit_event(0, "fid as i32", "local", &params, "        ");
        println!("        r3_mem.check_mem_grow(0, mem_size(APP_MEMID) as i32);");
        println!("    }}");
        println!("    call_depth = call_depth + 1;\n}}");
    }

    // Non-exported non-excluded: just call_depth
    let total = info.local_type_indices.len() as u32;
    let non_export: Vec<u32> = (info.num_imports..info.num_imports + total)
        .filter(|f| !excluded.contains(f) && !export_fids.contains(f)).collect();
    if !non_export.is_empty() {
        println!("wasm:opcode:*:before / opidx == 0 && ({}) / {{\n    call_depth = call_depth + 1;\n}}", eq_pred("fid", &non_export));
    }

    // func:exit
    println!("\nwasm:func:exit{} {{\n    call_depth = call_depth - 1;\n}}\n", exclude_pred(excluded));
}

fn emit_direct_call_probes(info: &WasmInfo, excluded: &[u32], npred: &str) {
    if excluded.is_empty() { return; }

    // IC
    println!("wasm:opcode:call:before / ({}) && {npred} / {{", eq_pred("imm0", excluded));
    println!("    r3_mem.record_ic(imm0 as i32);\n    call_depth = call_depth - 1;\n}}\n");

    // IR (grouped by return type)
    for (results, fids) in group_by_results(info, excluded) {
        println!("wasm:opcode:call{}:after / ({}) && {npred} / {{", ty_bounds("res", &results), eq_pred("imm0", &fids));
        emit_event(1, "imm0 as i32", "res", &results, "    ");
        println!("    r3_mem.check_mem_grow(0, mem_size(APP_MEMID) as i32);");
        println!("    call_depth = call_depth + 1;\n}}\n");
    }
}

fn emit_indirect_call_probes(info: &WasmInfo, excluded: &[u32], npred: &str) {
    if excluded.is_empty() { return; }

    // 3-phase flag pattern. We tried using resolved_fid (whamm#301) but it does only
    // init-time lookups — it doesn't see runtime table modifications, which breaks any
    // test that uses table.set or host table modification. The flag pattern uses
    // func:entry, which sees the actual function being entered regardless of how the
    // table was populated, so it works for all cases.
    println!("wasm:opcode:call_indirect:before {{\n    tracking_indirect = true;\n}}");

    // func:entry on excluded — detect indirect IC
    println!("wasm:func:entry / {} / {{", eq_pred("fid", excluded));
    println!("    if (tracking_indirect) {{");
    println!("        r3_mem.record_ic(fid as i32);");
    println!("        indirect_target_fid = fid as i32;");
    println!("        call_depth = call_depth - 1;");
    println!("        tracking_indirect = false;\n    }}\n}}");

    // func:entry on non-excluded — clear flag
    println!("wasm:func:entry / {npred} / {{");
    println!("    if (tracking_indirect) {{\n        tracking_indirect = false;\n        indirect_target_fid = -1;\n    }}\n}}\n");

    // call_indirect:after — typed first, void last
    let groups = group_by_results(info, excluded);
    let (void, typed): (Vec<_>, Vec<_>) = groups.iter().partition(|(r, _)| r.is_empty());

    for (results, _) in &typed {
        println!("wasm:opcode:call_indirect{}:after {{", ty_bounds("res", results));
        println!("    if (indirect_target_fid != -1) {{");
        emit_event(1, "indirect_target_fid", "res", results, "        ");
        println!("        r3_mem.check_mem_grow(0, mem_size(APP_MEMID) as i32);");
        println!("        call_depth = call_depth + 1;\n        indirect_target_fid = -1;\n    }}\n}}");
    }
    if !void.is_empty() {
        println!("wasm:opcode:call_indirect:after {{");
        println!("    if (indirect_target_fid != -1) {{");
        emit_event(1, "indirect_target_fid", "res", &[], "        ");
        println!("        r3_mem.check_mem_grow(0, mem_size(APP_MEMID) as i32);");
        println!("        call_depth = call_depth + 1;\n        indirect_target_fid = -1;\n    }}\n}}");
    }
}

fn emit_global_probes(info: &WasmInfo, excluded: &[u32]) {
    // Track exported mutable globals AND imported mutable globals
    let mut_globals: Vec<&GlobalInfo> = info.globals.iter()
        .filter(|g| g.mutable_ && (info.exported_globals.contains(&g.idx) || g.idx < info.num_imported_globals))
        .collect();
    if mut_globals.is_empty() { return; }

    let mut by_type: HashMap<ValType, Vec<u32>> = HashMap::new();
    for g in &mut_globals { by_type.entry(g.valtype).or_default().push(g.idx); }

    println!("\n// ── G (Global) events ────────────────────────────");
    for (valtype, idxs) in &by_type {
        let t = vt(valtype);
        let pred = if excluded.is_empty() { eq_pred("imm0", idxs) }
            else { format!("{} && ({})", neq_pred(excluded), eq_pred("imm0", idxs)) };

        println!("wasm:opcode:global.set(arg0: {t}):before / {pred} / {{");
        println!("    r3_mem.shadow_global_set(imm0 as i32, arg0 as i64);\n}}");
        println!("wasm:opcode:global.get(res0: {t}):after / {pred} / {{");
        println!("    r3_mem.{}(imm0 as i32, res0);\n}}", check_fn(valtype));
    }
}

fn emit_shadow_probes(epred: &str) {
    // memory.grow in non-excluded code: update shadow memory + shadow page count
    // (excluded code grows are detected at EC/IR boundaries via check_mem_grow)
    println!("\nwasm:opcode:memory.grow:after{epred} {{\n    r3_mem.shadow_grow(imm0 as i32, res0, arg0 as i32);\n}}");
    println!("wasm:opcode:memory.fill:before{epred} {{\n    r3_mem.shadow_fill(imm0 as i32, arg2 as i32, arg1 as i32, arg0 as i32);\n}}");
    // Same-memory copies only: whamm exposes a single memidx immediate on memory.copy.
    println!("wasm:opcode:memory.copy:before{epred} {{\n    r3_mem.shadow_copy(imm0 as i32, arg2 as i32, arg1 as i32, arg0 as i32);\n}}");
    // memory.init from a passive segment (registered at @init): imm0 = segidx, imm1 = memidx;
    // stack args top-first: arg0 = len, arg1 = src offset, arg2 = dest.
    println!("wasm:opcode:memory.init:before{epred} {{\n    r3_mem.shadow_init(imm1 as i32, imm0 as i32, arg2 as i32, arg1 as i32, arg0 as i32);\n}}");

    println!("\nwasm:opcode:i32.store|i32.store8|i32.store16:before{epred} {{");
    println!("    r3_mem.shadow_store(memory as i32, effective_addr as i32, data_size as i32, arg0 as i64);\n}}");
    println!("wasm:opcode:i64.store|i64.store8|i64.store16|i64.store32:before{epred} {{");
    println!("    r3_mem.shadow_store(memory as i32, effective_addr as i32, data_size as i32, arg0 as i64);\n}}");
    println!("wasm:opcode:f32.store:before{epred} {{");
    println!("    r3_mem.shadow_store_f32(memory as i32, effective_addr as i32, arg0);\n}}");
    println!("wasm:opcode:f64.store:before{epred} {{");
    println!("    r3_mem.shadow_store_f64(memory as i32, effective_addr as i32, arg0);\n}}");
    println!("wasm:opcode:i32.load|i32.load8_s|i32.load8_u|i32.load16_s|i32.load16_u:after{epred} {{");
    println!("    r3_mem.check_load(memory as i32, effective_addr as i32, data_size as i32, res0 as i64);\n}}");
    println!("wasm:opcode:i64.load|i64.load8_s|i64.load8_u|i64.load16_s|i64.load16_u|i64.load32_s|i64.load32_u:after{epred} {{");
    println!("    r3_mem.check_load(memory as i32, effective_addr as i32, data_size as i32, res0 as i64);\n}}");
    println!("wasm:opcode:f32.load:after{epred} {{");
    println!("    r3_mem.check_load_f32(memory as i32, effective_addr as i32, res0);\n}}");
    println!("wasm:opcode:f64.load:after{epred} {{");
    println!("    r3_mem.check_load_f64(memory as i32, effective_addr as i32, res0);\n}}");
}
