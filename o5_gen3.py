#!/usr/bin/env python3
import os
SEED=9505
OUT=os.path.join(os.path.dirname(__file__),"gen_tests")
def w(name,body,): open(os.path.join(OUT,name+".wat"),"w").write(body)

# 1. host grows memory index 1 (non-zero) -> documented undetectable by us
def multimem_grow_nonzero(name):
    L=["(module","  (memory (export \"memory\") 1)","  (memory 1)"]
    L.append("  (func $r3_main (export \"_start\") (export \"main\") call $r3_grow call $app_read)")
    L.append("  (func $r3_grow i32.const 1 memory.grow 1 drop)")
    L.append("  (func $app_read (export \"app_read\") i32.const 0 i32.load 1 drop)")
    L.append(")")
    w(name,"\n".join(L))
multimem_grow_nonzero("o5_mm_grow_mem1")

# 2. app itself grows memory (non-host) -> shadow_grow path
def app_grow(name):
    L=["(module","  (memory (export \"memory\") 1)"]
    L.append("  (func $r3_main (export \"_start\") (export \"main\") call $app_grow_read)")
    L.append("  (func $app_grow_read (export \"app_grow_read\") i32.const 2 memory.grow drop i32.const 0 i32.load drop)")
    L.append(")")
    w(name,"\n".join(L))
app_grow("o5_app_grow")

# 3. grow that FAILS (exceeds max) returns -1, no actual grow
def grow_fail(name):
    L=["(module","  (memory (export \"memory\") 1 1)"]  # max 1 page
    L.append("  (func $r3_main (export \"_start\") (export \"main\") call $r3_grow call $app_read)")
    L.append("  (func $r3_grow i32.const 5 memory.grow drop)")  # fails -> -1
    L.append("  (func $app_read (export \"app_read\") i32.const 0 i32.load drop)")
    L.append(")")
    w(name,"\n".join(L))
grow_fail("o5_grow_fail")

# 4. runtime table.set then call_indirect into host -> IC via func:entry
def runtime_tableset(name):
    L=["(module","  (memory (export \"memory\") 1)","  (table 4 funcref)","  (type $v (func))"]
    L.append("  (elem (i32.const 0) $r3_a $r3_b $r3_a $r3_b)")
    L.append("  (func $r3_main (export \"_start\") (export \"main\") call $app_use)")
    # app installs r3_b into slot 0 at runtime, then calls slot 0 -> IC
    L.append("  (func $app_use (export \"app_use\") (i32.store (i32.const 0)(i32.const 0)) i32.const 0 i32.const 3 table.set i32.const 0 call_indirect (type $v))")
    L.append("  (func $r3_a (type $v) nop)")
    L.append("  (func $r3_b (type $v) nop)")
    L.append(")")
    w(name,"\n".join(L))
runtime_tableset("o5_runtime_tableset")

# 5. float globals at scale -> G with floats
def float_globals(name,ng):
    L=["(module","  (memory (export \"memory\") 1)"]
    for i in range(ng):
        t="f32" if i%2==0 else "f64"
        init=f"f32.const {i}.5" if i%2==0 else f"f64.const {i}.25"
        L.append(f"  (global $g{i} (export \"g{i}\") (mut {t}) ({init}))")
    L.append("  (func $r3_main (export \"_start\") (export \"main\") call $r3_set call $app_read)")
    st=["  (func $r3_set"]
    for i in range(ng):
        if i%2==0: st.append(f"    f32.const {(i*3+SEED)%1000}.75 global.set {i}")
        else: st.append(f"    f64.const {(i*3+SEED)%1000}.125 global.set {i}")
    st.append("  )"); L+=st
    rd=["  (func $app_read (export \"app_read\")"]
    for i in range(ng): rd.append(f"    global.get {i} drop")
    rd.append("  )"); L+=rd; L.append(")")
    w(name,"\n".join(L))
float_globals("o5_float_globals_60",60)

# 6. large active data segment (48KB) seeding shadow, host overwrites one byte -> L
def big_data(name,size):
    L=["(module","  (memory (export \"memory\") 2)"]
    payload="".join(f"\\{((i+SEED)&0xff):02x}" for i in range(size))
    L.append(f"  (data (i32.const 0) \"{payload}\")")
    L.append("  (func $r3_main (export \"_start\") (export \"main\") call $r3_poke call $app_read)")
    L.append("  (func $r3_poke i32.const 100 i32.const %d i32.store)"%(SEED&0x7fffffff))
    rd=["  (func $app_read (export \"app_read\")"]
    rd.append("    i32.const 100 i32.load drop")   # L (host wrote)
    rd.append("    i32.const 0 i32.load drop")      # no L (data-seeded)
    rd.append("    i32.const %d i32.load drop"%(size-4))
    rd.append("  )"); L+=rd; L.append(")")
    w(name,"\n".join(L))
big_data("o5_bigdata_48k",48*1024)

# 7. deep self-recursion (runtime call depth, single EC)
def recurse(name,depth):
    L=["(module","  (memory (export \"memory\") 1)"]
    L.append("  (func $r3_main (export \"_start\") (export \"main\") call $r3_poke i32.const %d call $app_rec drop)"%depth)
    L.append("  (func $r3_poke i32.const 8 i32.const %d i32.store)"%(SEED&0x7fffffff))
    # app_rec(n): if n==0 load & return 0 else return app_rec(n-1)
    L.append("  (func $app_rec (export \"app_rec\") (param $n i32) (result i32)")
    L.append("    local.get $n i32.eqz if (result i32) i32.const 8 i32.load else local.get $n i32.const 1 i32.sub call $app_rec end)")
    L.append(")")
    w(name,"\n".join(L))
recurse("o5_recurse_400",400)

# 8. many mixed-type globals (i32/i64/f32/f64)
def mixed_globals(name,ng):
    L=["(module","  (memory (export \"memory\") 1)"]
    types=["i32","i64","f32","f64"]
    inits=["i32.const 1","i64.const 1","f32.const 1.5","f64.const 1.25"]
    sets=[]
    for i in range(ng):
        t=types[i%4]
        L.append(f"  (global $g{i} (export \"g{i}\") (mut {t}) ({inits[i%4]}))")
    L.append("  (func $r3_main (export \"_start\") (export \"main\") call $r3_set call $app_read)")
    st=["  (func $r3_set"]
    for i in range(ng):
        t=types[i%4]
        v={"i32":f"i32.const {(i+SEED)&0x7fffffff}","i64":f"i64.const {i+SEED}","f32":f"f32.const {i}.5","f64":f"f64.const {i}.25"}[t]
        st.append(f"    {v} global.set {i}")
    st.append("  )"); L+=st
    rd=["  (func $app_read (export \"app_read\")"]
    for i in range(ng): rd.append(f"    global.get {i} drop")
    rd.append("  )"); L+=rd; L.append(")")
    w(name,"\n".join(L))
mixed_globals("o5_mixed_globals_120",120)

# 9. sub-word load/store variety at scale (i32.store8/16, i32.load8_u etc.)
def subword(name,n):
    L=["(module","  (memory (export \"memory\") 1)"]
    L.append("  (func $r3_main (export \"_start\") (export \"main\") call $r3_poke call $app_f)")
    p=["  (func $r3_poke"]
    ops=[("i32.store8","i32.load8_u"),("i32.store16","i32.load16_u"),("i32.store","i32.load"),("i64.store8","i64.load8_u"),("i64.store32","i64.load32_u")]
    for i in range(n):
        st,ld=ops[i%len(ops)]
        val=f"i64.const {i+SEED}" if st.startswith("i64") else f"i32.const {(i+SEED)&0x7fffffff}"
        p.append(f"    i32.const {i*8} {val} {st}")
    p.append("  )"); L+=p
    b=["  (func $app_f (export \"app_f\")"]
    for i in range(n):
        st,ld=ops[i%len(ops)]
        b.append(f"    i32.const {i*8} {ld} drop")
    b.append("  )"); L+=b; L.append(")")
    w(name,"\n".join(L))
subword("o5_subword_150",150)

print("generated3")
