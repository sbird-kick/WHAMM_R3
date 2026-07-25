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
