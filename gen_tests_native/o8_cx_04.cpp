#include <cstdio>
constexpr int isqrt(int n){ int r=0; while((r+1)*(r+1)<=n) r++; return r; }
constexpr int TBL[24]={ isqrt(9808),isqrt(2),isqrt(9),isqrt(16),isqrt(30),isqrt(99),isqrt(100),isqrt(255),
  isqrt(1),isqrt(2),isqrt(3),isqrt(4),isqrt(5),isqrt(6),isqrt(7),isqrt(8),
  isqrt(10),isqrt(50),isqrt(64),isqrt(80),isqrt(121),isqrt(144),isqrt(200),isqrt(9808%400) };
int main(){ long s=0; for(int i=0;i<24;i++) s=s*3+TBL[i]; printf("%ld\n", s); return 0; }
