#include <cstdio>
struct Poly { long c[5];
  Poly operator+(const Poly&o)const{ Poly r{}; for(int i=0;i<5;i++) r.c[i]=c[i]+o.c[i]; return r; }
  long operator()(long x)const{ long s=0; for(int i=4;i>=0;i--) s=s*x+c[i]; return s; } };
int main(){
  Poly p{{9808%10,2,3,0,1}}, q{{1,1,1,1,1}};
  Poly r=p+q;
  printf("%ld %ld %ld\n", p(2), q(3), r(2));
  return 0;
}
