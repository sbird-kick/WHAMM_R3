#!/usr/bin/env python3
import os
SEED=9505
OUT=os.path.join(os.path.dirname(__file__),"gen_tests")
def w(name,body): open(os.path.join(OUT,name+".wat"),"w").write(body)

# 1. deeply nested blocks in one app func (control-structure depth)
def blocks_deep(name,d):
    L=["(module","  (memory (export \"memory\") 1)"]
    L.append("  (func $r3_main (export \"_start\") (export \"main\") call $r3_poke call $app_f)")
    L.append("  (func $r3_poke i32.const 64 i32.const %d i32.store)"%(SEED&0x7fffffff))
    b=["  (func $app_f (export \"app_f\")"]
    b += ["    block" for _ in range(d)]
    b.append("    i32.const 64 i32.load drop")
    b += ["    end" for _ in range(d)]
    b.append("  )")
    L+=b; L.append(")")
    w(name,"\n".join(L))
blocks_deep("o5_blocks_300",300)
blocks_deep("o5_blocks_600",600)

# 2. br_table with many targets
def brtable_big(name,n):
    L=["(module","  (memory (export \"memory\") 1)"]
    L.append("  (func $r3_main (export \"_start\") (export \"main\") call $r3_poke call $app_f)")
    L.append("  (func $r3_poke i32.const 72 i32.const %d i32.store)"%((SEED*2)&0x7fffffff))
    b=["  (func $app_f (export \"app_f\")"]
    b.append("    block")
    for _ in range(n): b.append("    block")
    # innermost: br_table on a constant index
    targets=" ".join(str(i) for i in range(n+1))
    b.append(f"    i32.const {n} br_table {targets}")
    for _ in range(n): b.append("    end")
    b.append("    end")
    b.append("    i32.const 72 i32.load drop")
    b.append("  )")
    L+=b; L.append(")")
    w(name,"\n".join(L))
brtable_big("o5_brtable_200",200)

# 3. one huge function: many loads/stores -> many L
def bigfunc(name,n):
    L=["(module","  (memory (export \"memory\") 1)"]
    L.append("  (func $r3_main (export \"_start\") (export \"main\") call $r3_poke call $app_f)")
    p=["  (func $r3_poke"]
    for i in range(n):
        p.append(f"    i32.const {8+(i*4)%60000} i32.const {(i+SEED)&0x7fffffff} i32.store")
    p.append("  )"); L+=p
    b=["  (func $app_f (export \"app_f\")"]
    for i in range(n):
        b.append(f"    i32.const {8+(i*4)%60000} i32.load drop")
    b.append("  )"); L+=b; L.append(")")
    w(name,"\n".join(L))
bigfunc("o5_bigfunc_2000",2000)
bigfunc("o5_bigfunc_5000",5000)

# 4. host grows memory repeatedly -> MG at boundaries
def grow_many(name,k):
    L=["(module","  (memory (export \"memory\") 1)"]
    calls=["  (func $r3_main (export \"_start\") (export \"main\")"]
    for i in range(k):
        calls.append("    call $r3_grow")
        calls.append("    call $app_read")
    calls.append("  )")
    L+=calls
    L.append("  (func $r3_grow i32.const 1 memory.grow drop)")
    L.append("  (func $app_read (export \"app_read\") i32.const 0 i32.load drop)")
    L.append(")")
    w(name,"\n".join(L))
grow_many("o5_grow_8",8)

# 5. i64 loads at scale
def typed_loads(name,ty,store,load,n):
    L=["(module","  (memory (export \"memory\") 1)"]
    L.append("  (func $r3_main (export \"_start\") (export \"main\") call $r3_poke call $app_f)")
    p=["  (func $r3_poke"]
    step=8
    for i in range(n):
        p.append(f"    i32.const {i*step} {store} {(i+SEED)}")
    p.append("  )"); L+=p
    b=["  (func $app_f (export \"app_f\")"]
    for i in range(n):
        b.append(f"    i32.const {i*step} {load} drop")
    b.append("  )"); L+=b; L.append(")")
    w(name,"\n".join(L))
typed_loads("o5_i64loads_300","i64","i64.store","i64.load",300)

# 6. mixed mega: 3 memories + 60 globals + 120 funcs + data segments
def mega(name):
    nmem=3; ng=60; nfn=120; nseg=20
    L=["(module"]
    for m in range(nmem):
        exp=' (export "memory")' if m==0 else ''
        L.append(f"  (memory{exp} 1)")
    for s in range(nseg):
        byte=(SEED+s)&0xff
        L.append(f"  (data (i32.const {s*8}) \"\\{byte:02x}\\{(byte+1)&0xff:02x}\")")
    for i in range(ng):
        L.append(f"  (global $g{i} (export \"g{i}\") (mut i64) (i64.const {i}))")
    main=["  (func $r3_main (export \"_start\") (export \"main\")","    call $r3_setup"]
    for i in range(nfn): main.append(f"    call $app_{i}")
    main.append("    call $app_globals")
    main.append("  )"); L+=main
    st=["  (func $r3_setup"]
    for m in range(nmem):
        st.append(f"    i32.const {100+m*8} i32.const {(SEED+m)&0x7fffffff} i32.store {m}")
    for i in range(ng):
        st.append(f"    i64.const {(i*7+SEED)} global.set {i}")
    st.append("  )"); L+=st
    for i in range(nfn):
        m=i%nmem
        L.append(f"  (func $app_{i} (export \"app_{i}\") i32.const {100+m*8} i32.load {m} drop)")
    g=["  (func $app_globals (export \"app_globals\")"]
    for i in range(ng): g.append(f"    global.get {i} drop")
    g.append("  )"); L+=g; L.append(")")
    w(name,"\n".join(L))
mega("o5_mega_mixed")

# 7. app calls host func with many params -> IC/IR (host in module, excluded)
def ic_manyparams(name,nparam):
    L=["(module","  (memory (export \"memory\") 1)"]
    L.append("  (func $r3_main (export \"_start\") (export \"main\") call $app_caller)")
    c=["  (func $app_caller (export \"app_caller\")"]
    for i in range(nparam): c.append(f"    i32.const {(i+SEED)&0x7fffffff}")
    c.append("    call $r3_host)")
    L+=c
    ptypes=" ".join("i32" for _ in range(nparam))
    L.append(f"  (func $r3_host (param {ptypes}) nop)")
    L.append(")")
    w(name,"\n".join(L))
ic_manyparams("o5_ic_params_80",80)

# 8. host func returns value read by... EC with long param list (i32) count 300
def params_300(name,nparam):
    L=["(module","  (memory (export \"memory\") 1)"]
    call=["  (func $r3_main (export \"_start\") (export \"main\")"]
    for i in range(nparam): call.append(f"    i32.const {(i*13+SEED)&0x7fffffff}")
    call.append("    call $app_f)")
    L+=call
    ptypes=" ".join("i32" for _ in range(nparam))
    L.append(f"  (func $app_f (export \"app_f\") (param {ptypes}) i32.const 8 i32.load drop)")
    L.append(")")
    w(name,"\n".join(L))
params_300("o5_params_300",300)

# 9. huge locals count in one func (whamm local-index stress)
def locals_huge(name,n):
    L=["(module","  (memory (export \"memory\") 1)"]
    L.append("  (func $r3_main (export \"_start\") (export \"main\") call $r3_poke call $app_f)")
    L.append("  (func $r3_poke i32.const 8 i32.const %d i32.store)"%(SEED&0x7fffffff))
    b=["  (func $app_f (export \"app_f\")","    (local "+" ".join("i64" for _ in range(n))+")"]
    b.append(f"    i64.const {SEED} local.set {n-1}")
    b.append("    i32.const 8 i32.load drop")
    b.append("  )"); L+=b; L.append(")")
    w(name,"\n".join(L))
locals_huge("o5_locals_1000",1000)

# 10. call_indirect across many APP funcs near threshold
def indirect_app(name,n):
    L=["(module","  (memory (export \"memory\") 1)",f"  (table {n} funcref)","  (type $v (func))"]
    L.append("  (elem (i32.const 0) "+" ".join(f"$t_{i}" for i in range(n))+")")
    L.append("  (func $r3_main (export \"_start\") (export \"main\") call $r3_poke call $driver)")
    L.append("  (func $r3_poke i32.const 24 i32.const %d i32.store)"%((SEED*3)&0x7fffffff))
    d=["  (func $driver (export \"driver\")"]
    for i in range(n): d.append(f"    i32.const {i} call_indirect (type $v)")
    d.append("  )"); L+=d
    for i in range(n): L.append(f"  (func $t_{i} (type $v) i32.const 24 i32.load drop)")
    L.append(")")
    w(name,"\n".join(L))
indirect_app("o5_indirect_app_500",500)

print("generated2")
