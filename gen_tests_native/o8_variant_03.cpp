#include <cstdio>
#include <variant>
#include <vector>
struct Add{int v;}; struct Mul{int v;}; struct Set{int v;};
using Op=std::variant<Add,Mul,Set>;
int main(){
  std::vector<Op> prog={ Set{9808%17}, Add{5}, Mul{3}, Add{100}, Mul{2}, Set{7}, Add{9808%9} };
  long acc=0;
  for(auto&op:prog) std::visit([&](auto&&o){ using T=std::decay_t<decltype(o)>;
    if constexpr(std::is_same_v<T,Add>) acc+=o.v;
    else if constexpr(std::is_same_v<T,Mul>) acc*=o.v;
    else acc=o.v; }, op);
  printf("%ld\n", acc);
  return 0;
}
