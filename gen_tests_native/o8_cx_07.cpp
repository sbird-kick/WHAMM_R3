#include <cstdio>
#include <array>
constexpr std::array<double,12> gauss(){ std::array<double,12> a{}; double v=1.0;
  for(int i=0;i<12;i++){ a[i]=v; v=v*0.5+0.1; } return a; }
constexpr auto G=gauss();
int main(){ double s=0; for(int i=0;i<12;i++) s+=G[i]*(i+1); printf("%.6f\n", s); return 0; }
