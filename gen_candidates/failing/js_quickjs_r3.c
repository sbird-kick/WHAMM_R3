/* js_quickjs_r3.c — R3 differential-test wrapper around QuickJS-ng (v0.10.1).
 *
 * Embeds a small deterministic JS program, evaluates it, and prints results
 * via a custom `print` global. Built for wasm32-wasip1 with wasi-sdk clang.
 *
 * Determinism measures:
 *   - Context built with JS_NewContextRaw + only the pure intrinsics; the
 *     Date and Performance intrinsics are intentionally NOT added, so no
 *     wall-clock is ever read and there is no time_origin.
 *   - clock_gettime/gettimeofday are overridden to fixed constants so that
 *     (a) the WASI clock_time_get import is never invoked (Wizard's JVM WASI
 *     backend does not implement it) and (b) any internal timestamp is fixed.
 *   - The embedded JS uses NO Date and NO Math.random.
 *
 * See js_BUILD.txt for exact fetch + build commands. The JS text also lives
 * standalone in js_quickjs_r3.js.
 */
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <sys/time.h>
#include "quickjs.h"

/* Deterministic clock overrides (see header comment). */
int clock_gettime(clockid_t clk_id, struct timespec *tp) {
    (void) clk_id;
    if (tp) { tp->tv_sec = 1700000000; tp->tv_nsec = 0; }
    return 0;
}
int gettimeofday(struct timeval *tv, void *tz) {
    (void) tz;
    if (tv) { tv->tv_sec = 1700000000; tv->tv_usec = 0; }
    return 0;
}

static JSValue js_print(JSContext *ctx, JSValueConst this_val,
                        int argc, JSValueConst *argv) {
    (void) this_val;
    for (int i = 0; i < argc; i++) {
        const char *s = JS_ToCString(ctx, argv[i]);
        if (!s) return JS_EXCEPTION;
        if (i) fputc(' ', stdout);
        fputs(s, stdout);
        JS_FreeCString(ctx, s);
    }
    fputc('\n', stdout);
    return JS_UNDEFINED;
}

static const char SRC[] =
    /* integer math */
    "var s=0; for (var i=1;i<=100;i++) s+=i*i; print('sumsq='+s);\n"
    /* array churn + closures */
    "function mkAdder(n){return function(x){return x+n;};}\n"
    "var add10=mkAdder(10); var arr=[];\n"
    "for (var i=0;i<20;i++) arr.push(add10(i));\n"
    "print('arr='+arr.join(','));\n"
    /* string ops */
    "var t='wasm'.repeat(3).toUpperCase(); print('str='+t+':'+t.length);\n"
    /* object/prototype */
    "function Pt(x,y){this.x=x;this.y=y;} Pt.prototype.norm=function(){return this.x*this.x+this.y*this.y;};\n"
    "var p=new Pt(3,4); print('norm='+p.norm());\n"
    /* JSON round-trip */
    "var o={a:1,b:[2,3],c:{d:'x'}}; var j=JSON.stringify(o); var back=JSON.parse(j);\n"
    "print('json='+j+':'+back.b[1]);\n"
    /* regex */
    "var m=('a1b22c333'.match(/\\d+/g)||[]).map(function(v){return v.length;});\n"
    "print('re='+m.join(','));\n";

int main(void) {
    JSRuntime *rt = JS_NewRuntime();
    if (!rt) { printf("no rt\n"); return 1; }
    /* Raw context: add only deterministic intrinsics (no Date/Performance). */
    JSContext *ctx = JS_NewContextRaw(rt);
    if (!ctx) { printf("no ctx\n"); return 1; }
    JS_AddIntrinsicBaseObjects(ctx);
    JS_AddIntrinsicEval(ctx);
    JS_AddIntrinsicRegExp(ctx);
    JS_AddIntrinsicJSON(ctx);
    JS_AddIntrinsicProxy(ctx);
    JS_AddIntrinsicMapSet(ctx);
    JS_AddIntrinsicTypedArrays(ctx);
    JS_AddIntrinsicBigInt(ctx);

    JSValue global = JS_GetGlobalObject(ctx);
    JS_SetPropertyStr(ctx, global, "print",
                      JS_NewCFunction(ctx, js_print, "print", 1));
    JS_FreeValue(ctx, global);

    JSValue val = JS_Eval(ctx, SRC, strlen(SRC), "<test>", JS_EVAL_TYPE_GLOBAL);
    if (JS_IsException(val)) {
        JSValue exc = JS_GetException(ctx);
        const char *s = JS_ToCString(ctx, exc);
        printf("EXC: %s\n", s ? s : "?");
        if (s) JS_FreeCString(ctx, s);
        JS_FreeValue(ctx, exc);
    }
    JS_FreeValue(ctx, val);
    JS_FreeContext(ctx);
    JS_FreeRuntime(rt);
    return 0;
}
