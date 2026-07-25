#include <cstdio>
#include <utility>
template<class...Ts> struct TypeList { static const int size=sizeof...(Ts); };
template<int...Is> constexpr long fold(){ long s=0; long a[]={Is...}; for(long x:a) s=s*3+x; return s; }
int main(){
  using L=TypeList<int,double,char,long,short>;
  printf("%d %ld\n", L::size, fold<9808,2,3,4,5>());
  return 0;
}
