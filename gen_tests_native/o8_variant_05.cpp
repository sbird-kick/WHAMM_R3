#include <cstdio>
#include <variant>
#include <vector>
using Cell=std::variant<std::monostate,long,double>;
int main(){
  std::vector<Cell> col={ std::monostate{}, (long)9808, 3.5, std::monostate{}, (long)42, 1.25 };
  double s=0; int nulls=0;
  for(auto&c:col){ if(std::holds_alternative<std::monostate>(c)) nulls++;
    else if(auto p=std::get_if<long>(&c)) s+=*p;
    else s+=std::get<double>(c); }
  printf("%.3f %d\n", s, nulls);
  return 0;
}
