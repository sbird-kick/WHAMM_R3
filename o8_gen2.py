#!/usr/bin/env python3
# Batch 2 of advanced-C++ R3 tests. Seed 9808, prefix o8_.
import os
OUT="gen_tests_native"
tests={}
def add(n,s): tests[n]=s

# ---- CRTP ----
add("o8_crtp_01", r'''
#include <cstdio>
template<class D> struct Shape { long area() const { return static_cast<const D*>(this)->area_impl(); }
  long tag() const { return static_cast<const D*>(this)->tag_impl(); } };
struct Sq : Shape<Sq> { long s; Sq(long x):s(x){} long area_impl()const{return s*s;} long tag_impl()const{return 1;} };
struct Rc : Shape<Rc> { long w,h; Rc(long a,long b):w(a),h(b){} long area_impl()const{return w*h;} long tag_impl()const{return 2;} };
int main(){
  Sq a(9808%13); Rc b(7, 9808%20);
  printf("%ld %ld %ld %ld\n", a.area(), b.area(), a.tag(), b.tag());
  return 0;
}
''')

add("o8_crtp_02", r'''
#include <cstdio>
template<class D> struct Counter { static int count; Counter(){count++;} };
template<class D> int Counter<D>::count=0;
struct A : Counter<A>{}; struct B : Counter<B>{};
int main(){
  int seed=9808%5;
  for(int i=0;i<seed+3;i++){ A a; }
  for(int i=0;i<2;i++){ B b; }
  printf("%d %d\n", A::count, B::count);
  return 0;
}
''')

# ---- complex / matrix operator overload ----
add("o8_op_04", r'''
#include <cstdio>
struct Cx { double re,im;
  Cx operator*(const Cx&o)const{return {re*o.re-im*o.im, re*o.im+im*o.re};}
  Cx operator+(const Cx&o)const{return {re+o.re, im+o.im};} };
int main(){
  Cx z{9808.0/10000, 0.5}, c=z;
  for(int i=0;i<8;i++) z = z*z + c;
  printf("%.5f %.5f\n", z.re, z.im);
  return 0;
}
''')

add("o8_op_05", r'''
#include <cstdio>
struct Mat2 { long a,b,c,d;
  Mat2 operator*(const Mat2&o)const{return {a*o.a+b*o.c, a*o.b+b*o.d, c*o.a+d*o.c, c*o.b+d*o.d};} };
int main(){
  Mat2 m{1,1,1,0}, r{1,0,0,1};
  int n=9808%12+3;
  for(int i=0;i<n;i++) r=r*m;
  printf("%ld %ld %ld %ld\n", r.a,r.b,r.c,r.d);
  return 0;
}
''')

# ---- std::function heavier + MG via vector ----
add("o8_fn_05", r'''
#include <cstdio>
#include <functional>
#include <vector>
int main(){
  std::vector<int> data;
  int seed=9808;
  auto push=[&](int k){ for(int i=0;i<k;i++){ data.push_back(seed%1000); seed=seed*1103515245+12345; } };
  std::function<long()> hash=[&](){ long h=1469598103934665603UL & 0x7fffffff; for(int x:data) h=(h^x)*16777619 & 0x7fffffff; return h; };
  push(200); push(300);
  printf("%zu %ld\n", data.size(), hash());
  return 0;
}
''')

add("o8_fn_06", r'''
#include <cstdio>
#include <functional>
struct State { long acc=9808; };
int main(){
  State st;
  std::function<void(int)> step;
  step=[&](int n){ if(n<=0) return; st.acc = (st.acc*31 + n) % 1000000007; step(n-1); };
  step(50);
  printf("%ld\n", st.acc);
  return 0;
}
''')

# ---- variant / visit ----
add("o8_variant_03", r'''
#include <cstdio>
#include <variant>
#include <vector>
struct Add{int v;}; struct Mul{int v;}; struct Set{int v;};
using Op=std::variant<Add,Mul,Set>;
int main(){
  std::vector<Op> prog={ Set{9808%17}, Add{5}, Mul{3}, Add{100}, Mul{2}, Set{7}, Add{9808%9} };
  long acc=0;
  for(auto&op:prog) std::visit([&](auto&&o){ using T=std::decay_t<decltype(o)>;
    if constexpr(std::is_same_v<T,Add>) acc+=o.v;
    else if constexpr(std::is_same_v<T,Mul>) acc*=o.v;
    else acc=o.v; }, op);
  printf("%ld\n", acc);
  return 0;
}
''')

add("o8_variant_04", r'''
#include <cstdio>
#include <variant>
using Num=std::variant<int,long,double>;
static double asd(const Num&n){ return std::visit([](auto v){return (double)v;}, n); }
int main(){
  Num arr[5]={ 9808, (long)123456789, 3.14159, 42, 2.5 };
  double s=0; for(auto&n:arr) s = s*1.5 + asd(n);
  printf("%.4f\n", s);
  return 0;
}
''')

# ---- constexpr ----
add("o8_cx_04", r'''
#include <cstdio>
constexpr int isqrt(int n){ int r=0; while((r+1)*(r+1)<=n) r++; return r; }
constexpr int TBL[24]={ isqrt(9808),isqrt(2),isqrt(9),isqrt(16),isqrt(30),isqrt(99),isqrt(100),isqrt(255),
  isqrt(1),isqrt(2),isqrt(3),isqrt(4),isqrt(5),isqrt(6),isqrt(7),isqrt(8),
  isqrt(10),isqrt(50),isqrt(64),isqrt(80),isqrt(121),isqrt(144),isqrt(200),isqrt(9808%400) };
int main(){ long s=0; for(int i=0;i<24;i++) s=s*3+TBL[i]; printf("%ld\n", s); return 0; }
''')

add("o8_cx_05", r'''
#include <cstdio>
#include <array>
template<int N> constexpr std::array<long,N> primes(){ std::array<long,N> p{}; int c=0; long n=2;
  while(c<N){ bool pr=true; for(int i=0;i<c;i++) if(n%p[i]==0){pr=false;break;} if(pr) p[c++]=n; n++; } return p; }
constexpr auto P=primes<30>();
int main(){ long s=0; for(int i=0;i<30;i++) s+=P[i]*(i+1); printf("%ld %ld\n", s, P[9808%30]); return 0; }
''')

# ---- placement new / aligned ----
add("o8_pnew_03", r'''
#include <cstdio>
#include <new>
#include <cstdint>
union Slot { double d; long l; int i[2]; };
int main(){
  alignas(8) unsigned char buf[sizeof(Slot)*6];
  long s=0;
  for(int i=0;i<6;i++){ Slot* sl=new(buf+i*sizeof(Slot)) Slot; sl->l=(long)i*9808+7; s^=sl->i[0]; s+=sl->l; }
  printf("%ld\n", s);
  return 0;
}
''')

add("o8_pnew_04", r'''
#include <cstdio>
#include <new>
#include <cstddef>
struct Widget { int id; virtual int cost() const { return id*10; } virtual ~Widget(){} };
struct Pro : Widget { int extra; int cost() const override { return id*10+extra; } };
int main(){
  alignas(16) unsigned char buf[128];
  Widget* w=new(buf) Widget{9808%40};
  Pro* p=new(buf+64) Pro; p->id=7; p->extra=9808%15;
  Widget* arr[2]={w,p};
  long s=0; for(auto*x:arr) s=s*100+x->cost();
  printf("%ld\n", s);
  return 0;
}
''')

# ---- template metaprog ----
add("o8_tmpl_06", r'''
#include <cstdio>
template<unsigned N> struct Pop { static const unsigned v = (N&1)+Pop<(N>>1)>::v; };
template<> struct Pop<0>{ static const unsigned v=0; };
int main(){
  unsigned s=0;
  s+=Pop<9808>::v; s+=Pop<0xFFFF>::v; s+=Pop<0xA5A5>::v; s+=Pop<255>::v; s+=Pop<0x1234>::v;
  printf("%u\n", s);
  return 0;
}
''')

add("o8_tmpl_07", r'''
#include <cstdio>
template<class T, int N> struct SmallVec { T d[N]; int n=0;
  void push(T x){ if(n<N) d[n++]=x; }
  T sum() const { T s=T(0); for(int i=0;i<n;i++) s+=d[i]; return s; } };
int main(){
  SmallVec<long,10> a; SmallVec<double,6> b;
  for(int i=0;i<8;i++) a.push((long)i*9808%777);
  for(int i=0;i<5;i++) b.push((double)(9808%(i+2))/3.0);
  printf("%ld %.4f\n", a.sum(), b.sum());
  return 0;
}
''')

# ---- string / vector (MG + IC/IR via printf) ----
add("o8_str_01", r'''
#include <cstdio>
#include <string>
#include <vector>
#include <algorithm>
int main(){
  std::vector<std::string> ws;
  const char* base="whammr3monitor";
  for(int i=0;i<26;i++){ std::string s; int seed=9808+i; for(int k=0;k<(i%7)+3;k++){ s+= (char)('a'+(seed%14)); s+=base[seed%14]; seed=seed*31+7; } ws.push_back(s); }
  std::sort(ws.begin(), ws.end());
  long h=0; for(auto&s:ws){ for(char c:s) h=(h*131+c)%1000000007; }
  printf("%zu %ld %s\n", ws.size(), h, ws.front().c_str());
  return 0;
}
''')

add("o8_str_02", r'''
#include <cstdio>
#include <string>
#include <map>
int main(){
  std::map<std::string,int> freq;
  const char* txt="the quick brown fox the lazy dog the fox 9808";
  std::string cur;
  for(const char*p=txt; ; ++p){ if(*p==' '||*p==0){ if(!cur.empty()){freq[cur]++; cur.clear();} if(*p==0) break; } else cur+=*p; }
  long h=0; for(auto&kv:freq) h = h*37 + kv.second*100 + kv.first.size();
  printf("%zu %ld\n", freq.size(), h);
  return 0;
}
''')

# ---- lambda capture combos ----
add("o8_lam_01", r'''
#include <cstdio>
int main(){
  int a=9808%50, b=7; long acc=0;
  auto mut=[a,&b,&acc]()mutable{ a+=b; b++; acc+=a; };
  for(int i=0;i<10;i++) mut();
  auto gen=[=]()->long{ return (long)a*1000+b; };
  printf("%ld %ld\n", acc, gen());
  return 0;
}
''')

add("o8_lam_02", r'''
#include <cstdio>
#include <vector>
#include <algorithm>
int main(){
  std::vector<int> v(40);
  int seed=9808; for(auto&x:v){ x=seed%200-100; seed=seed*1103515245+12345; }
  int pivot=9808%100-50;
  auto cnt=std::count_if(v.begin(),v.end(),[pivot](int x){return x>pivot;});
  std::sort(v.begin(),v.end(),[](int a,int b){return (a*a)<(b*b);});
  long h=0; for(int x:v) h=h*13+x;
  printf("%ld %ld\n", (long)cnt, h);
  return 0;
}
''')

# ---- inheritance + vtable dispatch array ----
add("o8_virt_01", r'''
#include <cstdio>
#include <vector>
#include <memory>
struct Expr { virtual long ev() const=0; virtual ~Expr(){} };
struct Lit : Expr { long v; Lit(long x):v(x){} long ev()const override{return v;} };
struct Bin : Expr { char op; Expr*l; Expr*r; Bin(char o,Expr*a,Expr*b):op(o),l(a),r(b){}
  long ev()const override{ long x=l->ev(),y=r->ev(); return op=='+'?x+y:op=='*'?x*y:x-y; } };
int main(){
  Lit a(9808%20), b(5), c(3);
  Bin m('*',&a,&b), s('+',&m,&c), d('-',&s,&a);
  printf("%ld %ld %ld\n", m.ev(), s.ev(), d.ev());
  return 0;
}
''')

# ---- std::optional-like via variant monostate ----
add("o8_variant_05", r'''
#include <cstdio>
#include <variant>
#include <vector>
using Cell=std::variant<std::monostate,long,double>;
int main(){
  std::vector<Cell> col={ std::monostate{}, (long)9808, 3.5, std::monostate{}, (long)42, 1.25 };
  double s=0; int nulls=0;
  for(auto&c:col){ if(std::holds_alternative<std::monostate>(c)) nulls++;
    else if(auto p=std::get_if<long>(&c)) s+=*p;
    else s+=std::get<double>(c); }
  printf("%.3f %d\n", s, nulls);
  return 0;
}
''')

if __name__=="__main__":
    os.makedirs(OUT,exist_ok=True)
    for n,s in tests.items():
        open(os.path.join(OUT,n+".cpp"),"w").write(s.lstrip())
    print("wrote",len(tests))
