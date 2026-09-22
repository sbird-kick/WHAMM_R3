;; gap_cross_memory_copy: memory.copy FROM memory $m0 INTO memory $m1 (two
;; distinct memidx immediates). Needs --enable-multi-memory in wat2wasm.
;;
;; This gives a concrete .wat repro for a limitation CLAUDE.md already
;; documents as a comment in script_gen ("cross-memory memory.copy
;; unroutable: whamm exposes one memidx imm") but does not yet have a named
;; regression file for. Mechanism:
;;
;; emit_shadow_probes emits exactly one probe body for ALL memory.copy sites:
;;     wasm:opcode:memory.copy:before { r3_mem.shadow_copy(imm0 as i32, arg2 as i32, arg1 as i32, arg0 as i32); }
;; For a 2-memidx memory.copy, whamm's `imm0` bound var resolves to only the
;; FIRST encoded memidx (the destination memory per the multi-memory
;; encoding order); there is no `imm1` for the source memory. So
;; shadow_copy(mem=dst_idx, dest, src, len) does:
;;     let sh = shadow_of(&mut s, mem);           // dst memory's shadow, ONLY
;;     sh.copy_within(sr..sr+n, d);                // reads src range FROM THE SAME (dst) shadow
;; i.e. it copies bytes from offset `src` of memory $m1's OWN shadow into
;; offset `dest` of memory $m1's shadow -- never touching memory $m0's
;; shadow at all. Real wasm actually moves $m0's bytes into $m1. Since
;; $m1 was never written at the source offset, its shadow there is still 0
;; (or whatever unrelated content $m1 had), while real $m1 now holds $m0's
;; distinct non-zero bytes -> check_load on the destination emits a
;; spurious/incorrect L (or, if $m1's stale shadow bytes happen to equal
;; $m0's true bytes by coincidence, a silently WRONG shadow that a later
;; write-then-compare could mask -- we pick non-matching byte patterns
;; below specifically so the divergence can't hide by coincidence).
(module
  (memory $m0 (export "mem0") 1)
  (memory $m1 (export "mem1") 1)
  (data (memory $m0) (i32.const 0) "\11\22\33\44\55\66\77\88")
  (data (memory $m1) (i32.const 0) "\00\00\00\00\00\00\00\00")
  (func $r3_main (export "_start")
    call $work)
  (func $work (export "work")
    ;; copy 8 bytes from $m0[0..8) into $m1[0..8)
    i32.const 0   ;; dest offset in $m1
    i32.const 0   ;; src offset in $m0
    i32.const 8   ;; len
    memory.copy $m1 $m0
    ;; observe the copied region in $m1 -- oracle sees $m0's bytes arrived;
    ;; our shadow, having copied within $m1's own (all-zero) shadow, still
    ;; thinks this is zero, so it should diverge here.
    i32.const 0 i32.load $m1 drop))
