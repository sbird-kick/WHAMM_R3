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
