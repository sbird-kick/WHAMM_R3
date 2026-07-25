#include <cstdio>
template<unsigned N> struct Pop { static const unsigned v = (N&1)+Pop<(N>>1)>::v; };
template<> struct Pop<0>{ static const unsigned v=0; };
int main(){
  unsigned s=0;
  s+=Pop<9808>::v; s+=Pop<0xFFFF>::v; s+=Pop<0xA5A5>::v; s+=Pop<255>::v; s+=Pop<0x1234>::v;
  printf("%u\n", s);
  return 0;
}
