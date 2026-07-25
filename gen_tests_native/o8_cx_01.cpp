#include <cstdio>
#include <array>
constexpr std::array<int,16> mk(){ std::array<int,16> a{}; for(int i=0;i<16;i++) a[i]=(i*i*9808)%251; return a; }
constexpr auto TBL = mk();
int main(){
  long s=0; for(int i=0;i<16;i++) s = s*5 + TBL[i];
  printf("%ld %d\n", s, TBL[9808%16]);
  return 0;
}
