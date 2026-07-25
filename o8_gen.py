#!/usr/bin/env python3
# Generate diverse advanced-C++ R3 differential tests. Seed 9808, prefix o8_.
import os
SEED = 9808
OUT = "gen_tests_native"
tests = {}

def add(name, src):
    tests[name] = src

# ---------------- templates across types ----------------
add("o8_tmpl_02", r'''
#include <cstdio>
#include <cstdint>
template<class T> struct Poly { T a,b,c;
  T eval(T x) const { return a*x*x + b*x + c; } };
template<class T> T run(T x){ Poly<T> p{T(2),T(9808%13),T(3)}; return p.eval(x); }
int main(){
  int  ri = run<int>(7);
  long rl = run<long>(11);
  int64_t rq = run<int64_t>(9808%17);
  printf("%d %ld %lld\n", ri, rl, (long long)rq);
  return 0;
}
''')

add("o8_tmpl_03", r'''
#include <cstdio>
template<int N> struct Fib { static const long v = Fib<N-1>::v + Fib<N-2>::v; };
template<> struct Fib<0>{ static const long v=0; };
template<> struct Fib<1>{ static const long v=1; };
template<class T, int N> T dot(const T(&a)[N], const T(&b)[N]){ T s=T(0); for(int i=0;i<N;i++) s+=a[i]*b[i]; return s; }
int main(){
  double x[3]={1.5,2.5,3.5}, y[3]={9808.0/1000,2.0,0.5};
  int   u[4]={9808%7,2,3,4}, w[4]={5,6,7,8};
  printf("%ld %.3f %d\n", Fib<20>::v, dot<double,3>(x,y), dot<int,4>(u,w));
  return 0;
}
''')

add("o8_tmpl_04", r'''
#include <cstdio>
#include <type_traits>
template<class T> typename std::enable_if<std::is_integral<T>::value,T>::type f(T x){ return x*3+9808; }
template<class T> typename std::enable_if<std::is_floating_point<T>::value,T>::type f(T x){ return x/2 + 0.5; }
int main(){
  printf("%d %lld %.4f\n", f<int>(10), (long long)f<long long>(1000), f<double>(9808.0/64));
  return 0;
}
''')

add("o8_tmpl_05", r'''
#include <cstdio>
#include <tuple>
template<class...A> long sum(A...a){ long s=0; long arr[]={ (long)a... }; for(long v:arr) s+=v; return s; }
int main(){
  auto t = std::make_tuple(9808, 2.5, 'A');
  long s = sum(1,2,3,9808%11,5,6);
  printf("%d %.1f %c %ld\n", std::get<0>(t), std::get<1>(t), std::get<2>(t), s);
  return 0;
}
''')

# ---------------- virtual inheritance diamonds ----------------
add("o8_vdiamond_01", r'''
#include <cstdio>
struct Base { int b; Base(int x):b(x){} virtual int who() const {return b;} virtual ~Base(){} };
struct L : virtual Base { L():Base(9808%50){} int who() const override {return b+1;} };
struct R : virtual Base { R(){} int who() const override {return b+2;} };
struct D : L, R { D(){} int who() const override {return b+100;} };
int main(){
  D d; Base* p=&d;
  L* l=&d; R* r=&d;
  printf("%d %d %d %d\n", p->who(), l->b, r->b, ((Base*)l)->b);
  return 0;
}
''')

add("o8_vdiamond_02", r'''
#include <cstdio>
struct A { int v; A(int x):v(x){} virtual int g() const {return v*2;} virtual ~A(){} };
struct B1 : virtual A { B1():A(9808%30){} int g() const override {return v*3;} };
struct B2 : virtual A { B2(){} int g() const override {return v*5;} };
struct C : B1, B2 { C(){} int g() const override {return B1::g()+B2::g();} };
int main(){
  C c; A* a=&c;
  int s=0; A* arr[3]={ &c, (A*)(B1*)&c, (A*)(B2*)&c };
  for(A* x:arr) s = s*7 + x->g();
  printf("%d %d\n", a->g(), s);
  return 0;
}
''')

add("o8_vdiamond_03", r'''
#include <cstdio>
struct Animal { int id; Animal(int i):id(i){} virtual int sound() const=0; virtual ~Animal(){} };
struct Legged : virtual Animal { int legs; Legged(int l):Animal(9808%20),legs(l){} };
struct Winged : virtual Animal { int wings; Winged(int w):Animal(9808%20),wings(w){} };
struct Griffin : Legged, Winged {
  Griffin():Animal(9808%20),Legged(4),Winged(2){}
  int sound() const override { return id*1000 + legs*10 + wings; }
};
int main(){
  Griffin g; Animal* a=&g;
  printf("%d %d %d\n", a->sound(), g.legs, g.wings);
  return 0;
}
''')

# ---------------- std::function and lambdas ----------------
add("o8_fn_01", r'''
#include <cstdio>
#include <functional>
#include <vector>
int main(){
  int cap = 9808 % 100;
  std::function<int(int)> f = [cap](int x){ return x*x + cap; };
  std::function<int(int)> g = [&](int x){ return f(x) - cap/2; };
  std::vector<std::function<int(int)>> fs = { f, g, [](int x){return x+1;} };
  long s=0; for(auto& h:fs) for(int i=0;i<5;i++) s = s*3 + h(i);
  printf("%ld\n", s);
  return 0;
}
''')

add("o8_fn_02", r'''
#include <cstdio>
#include <functional>
struct Counter { int n=9808%7; int operator()(int x){ n+=x; return n; } };
int main(){
  std::function<int(int)> c = Counter{};
  int acc=0; for(int i=0;i<10;i++) acc += c(i);
  std::function<long()> gen = [acc](){ return (long)acc*9808; };
  printf("%d %ld\n", acc, gen());
  return 0;
}
''')

add("o8_fn_03", r'''
#include <cstdio>
#include <functional>
#include <vector>
static std::function<long(long)> make_adder(long k){ return [k](long x){ return x+k; }; }
static std::function<long(long)> compose(std::function<long(long)> a, std::function<long(long)> b){
  return [a,b](long x){ return a(b(x)); };
}
int main(){
  auto f = compose(make_adder(9808%13), make_adder(100));
  auto g = compose(f, [](long x){return x*2;});
  long s=0; for(long i=0;i<8;i++) s += g(i);
  printf("%ld\n", s);
  return 0;
}
''')

add("o8_fn_04", r'''
#include <cstdio>
#include <functional>
#include <map>
int main(){
  std::map<int, std::function<int(int,int)>> ops;
  ops[0]=[](int a,int b){return a+b;};
  ops[1]=[](int a,int b){return a-b;};
  ops[2]=[](int a,int b){return a*b;};
  int seed=9808; long s=0;
  for(int i=0;i<12;i++){ int op=i%3; s=s*5 + ops[op](seed%50, i+1); seed=seed*1103515245+12345; }
  printf("%ld\n", s);
  return 0;
}
''')

# ---------------- operator overloading ----------------
add("o8_op_01", r'''
#include <cstdio>
struct Vec3 { long x,y,z;
  Vec3 operator+(const Vec3&o)const{return {x+o.x,y+o.y,z+o.z};}
  Vec3 operator*(long s)const{return {x*s,y*s,z*s};}
  long operator%(const Vec3&o)const{return x*o.x+y*o.y+z*o.z;} };
int main(){
  Vec3 a{9808%9,2,3}, b{4,5,6};
  Vec3 c = (a+b)*3;
  printf("%ld %ld %ld %ld\n", c.x,c.y,c.z, a%b);
  return 0;
}
''')

add("o8_op_02", r'''
#include <cstdio>
struct Frac { long n,d;
  Frac operator+(const Frac&o)const{return {n*o.d+o.n*d, d*o.d};}
  Frac operator*(const Frac&o)const{return {n*o.n, d*o.d};}
  bool operator<(const Frac&o)const{return n*o.d < o.n*d;} };
int main(){
  Frac a{9808%5+1,3}, b{2,7};
  Frac s = a+b, p = a*b;
  printf("%ld/%ld %ld/%ld %d\n", s.n,s.d,p.n,p.d, (int)(a<b));
  return 0;
}
''')

add("o8_op_03", r'''
#include <cstdio>
struct Big { unsigned lo, hi;
  Big& operator<<=(int k){ hi=(hi<<k)|(lo>>(32-k)); lo<<=k; return *this; }
  Big operator^(const Big&o)const{return {lo^o.lo, hi^o.hi};}
  unsigned operator[](int i)const{ return i?hi:lo; } };
int main(){
  Big a{9808u, 0x1234u};
  a<<=4; Big b = a ^ Big{0xFFu,0xAAu};
  printf("%u %u %u\n", b[0], b[1], a[1]);
  return 0;
}
''')

# ---------------- placement new / aligned buffers ----------------
add("o8_pnew_01", r'''
#include <cstdio>
#include <new>
#include <cstdint>
struct Node { int id; long payload; Node(int i):id(i),payload((long)i*9808){} };
int main(){
  alignas(16) unsigned char buf[sizeof(Node)*4];
  long s=0;
  for(int i=0;i<4;i++){ Node* n = new (buf + i*sizeof(Node)) Node(i+ (9808%3)); s = s*7 + n->payload + n->id; }
  Node* arr = reinterpret_cast<Node*>(buf);
  for(int i=0;i<4;i++){ arr[i].~Node(); }
  printf("%ld\n", s);
  return 0;
}
''')

add("o8_pnew_02", r'''
#include <cstdio>
#include <new>
#include <cstdint>
template<class T, int N> struct Arena {
  alignas(alignof(T)) unsigned char mem[sizeof(T)*N]; int used=0;
  template<class...A> T* make(A...a){ T* p=new(mem+used*sizeof(T)) T(a...); used++; return p; }
};
struct P { double x,y; P(double a,double b):x(a),y(b){} };
int main(){
  Arena<P,8> ar;
  double s=0;
  for(int i=0;i<6;i++){ P* p=ar.make((double)i, (double)(9808%17)/i - i); s += p->x - p->y; }
  printf("%.4f %d\n", s, ar.used);
  return 0;
}
''')

# ---------------- std::variant / visit ----------------
add("o8_variant_01", r'''
#include <cstdio>
#include <variant>
#include <vector>
using V = std::variant<int,double,long>;
struct Vis { long operator()(int x){return x*2;} long operator()(double x){return (long)(x*10);} long operator()(long x){return x+9808;} };
int main(){
  std::vector<V> vs = { 5, 2.5, (long)100, 9808%40, 3.14 };
  long s=0; for(auto&v:vs) s = s*3 + std::visit(Vis{}, v);
  printf("%ld\n", s);
  return 0;
}
''')

add("o8_variant_02", r'''
#include <cstdio>
#include <variant>
#include <string>
using V = std::variant<int, std::string, double>;
int main(){
  V a = 9808%50; V b = std::string("hi"); V c = 2.718;
  long s=0;
  s += std::holds_alternative<int>(a) ? std::get<int>(a) : 0;
  s += std::holds_alternative<std::string>(b) ? (long)std::get<std::string>(b).size()*1000 : 0;
  s += (long)(std::get<double>(c)*100);
  printf("%ld %zu\n", s, a.index()+b.index()+c.index());
  return 0;
}
''')

# ---------------- constexpr tables ----------------
add("o8_cx_01", r'''
#include <cstdio>
#include <array>
constexpr std::array<int,16> mk(){ std::array<int,16> a{}; for(int i=0;i<16;i++) a[i]=(i*i*9808)%251; return a; }
constexpr auto TBL = mk();
int main(){
  long s=0; for(int i=0;i<16;i++) s = s*5 + TBL[i];
  printf("%ld %d\n", s, TBL[9808%16]);
  return 0;
}
''')

add("o8_cx_02", r'''
#include <cstdio>
constexpr long fact(int n){ return n<=1?1:n*fact(n-1); }
constexpr long POW[10] = { fact(1),fact(2),fact(3),fact(4),fact(5),fact(6),fact(7),fact(8),fact(9),fact(10) };
int main(){
  long s=0; for(int i=0;i<10;i++) s += POW[i] % (9808+i);
  printf("%ld %ld\n", s, POW[9]);
  return 0;
}
''')

add("o8_cx_03", r'''
#include <cstdio>
#include <cstdint>
struct CRC { uint32_t t[256];
  constexpr CRC():t(){ for(uint32_t i=0;i<256;i++){ uint32_t c=i; for(int k=0;k<8;k++) c = c&1?0xEDB88320u^(c>>1):c>>1; t[i]=c; } } };
constexpr CRC C{};
int main(){
  const char* msg="whamm-r3-9808";
  uint32_t crc=0xFFFFFFFFu;
  for(const char*p=msg;*p;p++) crc = C.t[(crc^ (uint8_t)*p)&0xFF] ^ (crc>>8);
  printf("%08x\n", crc^0xFFFFFFFFu);
  return 0;
}
''')

if __name__=="__main__":
    os.makedirs(OUT, exist_ok=True)
    for name, src in tests.items():
        with open(os.path.join(OUT, name+".cpp"),"w") as f:
            f.write(src.lstrip())
    print("wrote", len(tests), "tests")
