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
