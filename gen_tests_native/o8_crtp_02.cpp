#include <cstdio>
template<class D> struct Counter { static int count; Counter(){count++;} };
template<class D> int Counter<D>::count=0;
struct A : Counter<A>{}; struct B : Counter<B>{};
int main(){
  int seed=9808%5;
  for(int i=0;i<seed+3;i++){ A a; }
  for(int i=0;i<2;i++){ B b; }
  printf("%d %d\n", A::count, B::count);
  return 0;
}
