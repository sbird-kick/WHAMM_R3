#include <cstdio>
template<int N> struct Fib { static const long v = Fib<N-1>::v + Fib<N-2>::v; };
template<> struct Fib<0>{ static const long v=0; };
template<> struct Fib<1>{ static const long v=1; };
template<class T, int N> T dot(const T(&a)[N], const T(&b)[N]){ T s=T(0); for(int i=0;i<N;i++) s+=a[i]*b[i]; return s; }
int main(){
  double x[3]={1.5,2.5,3.5}, y[3]={9808.0/1000,2.0,0.5};
  int   u[4]={9808%7,2,3,4}, w[4]={5,6,7,8};
  printf("%ld %.3f %d\n", Fib<20>::v, dot<double,3>(x,y), dot<int,4>(u,w));
  return 0;
}
