#include <cstdio>
#include <variant>
#include <vector>
using V = std::variant<int,double,long>;
struct Vis { long operator()(int x){return x*2;} long operator()(double x){return (long)(x*10);} long operator()(long x){return x+9808;} };
int main(){
  std::vector<V> vs = { 5, 2.5, (long)100, 9808%40, 3.14 };
  long s=0; for(auto&v:vs) s = s*3 + std::visit(Vis{}, v);
  printf("%ld\n", s);
  return 0;
}
