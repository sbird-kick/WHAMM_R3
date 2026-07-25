#include <cstdio>
#include <variant>
using Num=std::variant<int,long,double>;
static double asd(const Num&n){ return std::visit([](auto v){return (double)v;}, n); }
int main(){
  Num arr[5]={ 9808, (long)123456789, 3.14159, 42, 2.5 };
  double s=0; for(auto&n:arr) s = s*1.5 + asd(n);
  printf("%.4f\n", s);
  return 0;
}
