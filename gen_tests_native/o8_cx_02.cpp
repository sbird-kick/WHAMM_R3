#include <cstdio>
constexpr long fact(int n){ return n<=1?1:n*fact(n-1); }
constexpr long POW[10] = { fact(1),fact(2),fact(3),fact(4),fact(5),fact(6),fact(7),fact(8),fact(9),fact(10) };
int main(){
  long s=0; for(int i=0;i<10;i++) s += POW[i] % (9808+i);
  printf("%ld %ld\n", s, POW[9]);
  return 0;
}
