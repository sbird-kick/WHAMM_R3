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
