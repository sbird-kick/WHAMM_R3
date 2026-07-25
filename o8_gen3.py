#!/usr/bin/env python3
# Batch 3 advanced-C++ R3 tests. Seed 9808, prefix o8_.
import os
OUT="gen_tests_native"; tests={}
def add(n,s): tests[n]=s

add("o8_tmpl_08", r'''
#include <cstdio>
template<class T> struct Wrap { T v; template<class U> auto add(U u)->decltype(v+u){ return v+u; } };
int main(){
  Wrap<int> a{9808%40}; Wrap<double> b{2.5};
  printf("%d %.3f %ld\n", a.add(3), b.add(1), (long)a.add(1000000L));
  return 0;
}
''')

add("o8_tmpl_09", r'''
#include <cstdio>
#include <utility>
template<class...Ts> struct TypeList { static const int size=sizeof...(Ts); };
template<int...Is> constexpr long fold(){ long s=0; long a[]={Is...}; for(long x:a) s=s*3+x; return s; }
int main(){
  using L=TypeList<int,double,char,long,short>;
  printf("%d %ld\n", L::size, fold<9808,2,3,4,5>());
  return 0;
}
''')

add("o8_op_06", r'''
#include <cstdio>
struct Q { long a,b,c,d;
  Q operator*(const Q&o)const{ return {
    a*o.a-b*o.b-c*o.c-d*o.d, a*o.b+b*o.a+c*o.d-d*o.c,
    a*o.c-b*o.d+c*o.a+d*o.b, a*o.d+b*o.c-c*o.b+d*o.a }; } };
int main(){
  Q q{1,9808%3,1,0}, r=q;
  for(int i=0;i<5;i++) r=r*q;
  printf("%ld %ld %ld %ld\n", r.a,r.b,r.c,r.d);
  return 0;
}
''')

add("o8_op_07", r'''
#include <cstdio>
struct Poly { long c[5];
  Poly operator+(const Poly&o)const{ Poly r{}; for(int i=0;i<5;i++) r.c[i]=c[i]+o.c[i]; return r; }
  long operator()(long x)const{ long s=0; for(int i=4;i>=0;i--) s=s*x+c[i]; return s; } };
int main(){
  Poly p{{9808%10,2,3,0,1}}, q{{1,1,1,1,1}};
  Poly r=p+q;
  printf("%ld %ld %ld\n", p(2), q(3), r(2));
  return 0;
}
''')

add("o8_variant_06", r'''
#include <cstdio>
#include <variant>
#include <vector>
struct Point{double x,y;}; struct Circle{double r;}; struct Rect{double w,h;};
using Shape=std::variant<Point,Circle,Rect>;
struct Area{ double operator()(const Point&)const{return 0;}
  double operator()(const Circle&c)const{return 3.14159265*c.r*c.r;}
  double operator()(const Rect&r)const{return r.w*r.h;} };
int main(){
  std::vector<Shape> sh={ Point{1,2}, Circle{(double)(9808%10)/2}, Rect{3,4}, Circle{2}, Rect{(double)(9808%7),5} };
  double s=0; for(auto&x:sh) s+=std::visit(Area{},x);
  printf("%.5f\n", s);
  return 0;
}
''')

add("o8_cx_06", r'''
#include <cstdio>
constexpr unsigned hashstr(const char*s){ unsigned h=2166136261u; while(*s){ h=(h^(unsigned char)*s)*16777619u; s++; } return h; }
constexpr unsigned H[6]={ hashstr("whamm"),hashstr("r3"),hashstr("monitor"),hashstr("9808"),hashstr("oracle"),hashstr("trace") };
int main(){ unsigned s=0; for(int i=0;i<6;i++) s^=H[i]+(unsigned)(i*9808); printf("%u\n", s); return 0; }
''')

add("o8_cx_07", r'''
#include <cstdio>
#include <array>
constexpr std::array<double,12> gauss(){ std::array<double,12> a{}; double v=1.0;
  for(int i=0;i<12;i++){ a[i]=v; v=v*0.5+0.1; } return a; }
constexpr auto G=gauss();
int main(){ double s=0; for(int i=0;i<12;i++) s+=G[i]*(i+1); printf("%.6f\n", s); return 0; }
''')

add("o8_pnew_05", r'''
#include <cstdio>
#include <new>
template<int SZ> struct Pool { alignas(16) unsigned char buf[SZ]; int off=0;
  void* alloc(int n,int al){ int a=(off+al-1)&~(al-1); off=a+n; return buf+a; } };
struct Rec{ long k; double v; };
int main(){
  Pool<512> pool;
  long s=0;
  for(int i=0;i<10;i++){ Rec* r=new(pool.alloc(sizeof(Rec),alignof(Rec))) Rec{(long)i*9808, (double)i/3}; s+=r->k; s+=(long)(r->v*100); }
  printf("%ld %d\n", s, pool.off);
  return 0;
}
''')

add("o8_fn_07", r'''
#include <cstdio>
#include <functional>
#include <vector>
int main(){
  std::vector<std::function<long(long)>> pipe;
  int seed=9808;
  for(int i=0;i<6;i++){ long k=seed%20; pipe.push_back([k,i](long x){ return i%2? x+k : x*2-k; }); seed=seed*31+1; }
  long v=9808%100;
  for(auto&f:pipe) v=f(v);
  printf("%ld\n", v);
  return 0;
}
''')

add("o8_virt_02", r'''
#include <cstdio>
struct Visitor;
struct Node { virtual long accept(Visitor&) =0; virtual ~Node(){} };
struct Leaf; struct Branch;
struct Visitor { virtual long vl(Leaf&)=0; virtual long vb(Branch&)=0; virtual ~Visitor(){} };
struct Leaf : Node { long v; Leaf(long x):v(x){} long accept(Visitor&vi) override; };
struct Branch : Node { Node*a; Node*b; Branch(Node*x,Node*y):a(x),b(y){} long accept(Visitor&vi) override; };
struct Sum : Visitor { long vl(Leaf&l) override{return l.v;} long vb(Branch&b) override{return b.a->accept(*this)+b.b->accept(*this);} };
long Leaf::accept(Visitor&vi){ return vi.vl(*this); }
long Branch::accept(Visitor&vi){ return vi.vb(*this); }
int main(){
  Leaf a(9808%30), b(5), c(7);
  Branch x(&a,&b), y(&x,&c);
  Sum s; printf("%ld\n", y.accept(s));
  return 0;
}
''')

add("o8_tmpl_10", r'''
#include <cstdio>
template<class T> struct Stack { T d[32]; int n=0; void push(T x){d[n++]=x;} T pop(){return d[--n];} bool empty(){return n==0;} };
int main(){
  Stack<long> s;
  const char* rpn="9808 2 * 3 + 5 -";
  long acc=0; long nums[16]; int ni=0; long cur=0; bool innum=false;
  for(const char*p=rpn;;++p){ char c=*p;
    if(c>='0'&&c<='9'){ cur=cur*10+(c-'0'); innum=true; }
    else { if(innum){ s.push(cur); cur=0; innum=false; }
      if(c=='+'){long b=s.pop(),a=s.pop();s.push(a+b);}
      else if(c=='*'){long b=s.pop(),a=s.pop();s.push(a*b);}
      else if(c=='-'){long b=s.pop(),a=s.pop();s.push(a-b);}
      if(c==0) break; } }
  (void)nums;(void)ni;(void)acc;
  printf("%ld\n", s.pop());
  return 0;
}
''')

if __name__=="__main__":
    for n,s in tests.items(): open(os.path.join(OUT,n+".cpp"),"w").write(s.lstrip())
    print("wrote",len(tests))
