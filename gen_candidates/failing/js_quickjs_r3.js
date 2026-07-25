// Embedded JS program for js_quickjs_r3 (see js_quickjs_r3.c).
// Deterministic: no Date, no Math.random, no environment reads.
// Exercises integer math, array churn, closures, string ops, prototypes,
// JSON round-trip, and regex.

// integer math
var s = 0; for (var i = 1; i <= 100; i++) s += i * i; print('sumsq=' + s);

// array churn + closures
function mkAdder(n) { return function (x) { return x + n; }; }
var add10 = mkAdder(10); var arr = [];
for (var i = 0; i < 20; i++) arr.push(add10(i));
print('arr=' + arr.join(','));

// string ops
var t = 'wasm'.repeat(3).toUpperCase(); print('str=' + t + ':' + t.length);

// object/prototype
function Pt(x, y) { this.x = x; this.y = y; }
Pt.prototype.norm = function () { return this.x * this.x + this.y * this.y; };
var p = new Pt(3, 4); print('norm=' + p.norm());

// JSON round-trip
var o = { a: 1, b: [2, 3], c: { d: 'x' } };
var j = JSON.stringify(o); var back = JSON.parse(j);
print('json=' + j + ':' + back.b[1]);

// regex
var m = ('a1b22c333'.match(/\d+/g) || []).map(function (v) { return v.length; });
print('re=' + m.join(','));

// Expected stdout (deterministic):
//   sumsq=338350
//   arr=10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29
//   str=WASMWASMWASM:12
//   norm=25
//   json={"a":1,"b":[2,3],"c":{"d":"x"}}:3
//   re=1,2,3
