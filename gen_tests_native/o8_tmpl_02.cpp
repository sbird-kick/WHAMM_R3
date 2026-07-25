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
