#include <cstdio>
#include <tuple>
template<class...A> long sum(A...a){ long s=0; long arr[]={ (long)a... }; for(long v:arr) s+=v; return s; }
int main(){
  auto t = std::make_tuple(9808, 2.5, 'A');
  long s = sum(1,2,3,9808%11,5,6);
  printf("%d %.1f %c %ld\n", std::get<0>(t), std::get<1>(t), std::get<2>(t), s);
  return 0;
}
