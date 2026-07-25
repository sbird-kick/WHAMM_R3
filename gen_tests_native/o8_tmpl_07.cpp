#include <cstdio>
template<class T, int N> struct SmallVec { T d[N]; int n=0;
  void push(T x){ if(n<N) d[n++]=x; }
  T sum() const { T s=T(0); for(int i=0;i<n;i++) s+=d[i]; return s; } };
int main(){
  SmallVec<long,10> a; SmallVec<double,6> b;
  for(int i=0;i<8;i++) a.push((long)i*9808%777);
  for(int i=0;i<5;i++) b.push((double)(9808%(i+2))/3.0);
  printf("%ld %.4f\n", a.sum(), b.sum());
  return 0;
}
