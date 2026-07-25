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
