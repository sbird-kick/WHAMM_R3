#include <cstdio>
template<class T> struct Wrap { T v; template<class U> auto add(U u)->decltype(v+u){ return v+u; } };
int main(){
  Wrap<int> a{9808%40}; Wrap<double> b{2.5};
  printf("%d %.3f %ld\n", a.add(3), b.add(1), (long)a.add(1000000L));
  return 0;
}
