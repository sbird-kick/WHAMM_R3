#include <cstdio>
#include <variant>
#include <string>
using V = std::variant<int, std::string, double>;
int main(){
  V a = 9808%50; V b = std::string("hi"); V c = 2.718;
  long s=0;
  s += std::holds_alternative<int>(a) ? std::get<int>(a) : 0;
  s += std::holds_alternative<std::string>(b) ? (long)std::get<std::string>(b).size()*1000 : 0;
  s += (long)(std::get<double>(c)*100);
  printf("%ld %zu\n", s, a.index()+b.index()+c.index());
  return 0;
}
