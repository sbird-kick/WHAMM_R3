#include <cstdio>
#include <array>
template<int N> constexpr std::array<long,N> primes(){ std::array<long,N> p{}; int c=0; long n=2;
  while(c<N){ bool pr=true; for(int i=0;i<c;i++) if(n%p[i]==0){pr=false;break;} if(pr) p[c++]=n; n++; } return p; }
constexpr auto P=primes<30>();
int main(){ long s=0; for(int i=0;i<30;i++) s+=P[i]*(i+1); printf("%ld %ld\n", s, P[9808%30]); return 0; }
