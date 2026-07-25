#include <cstdio>
#include <functional>
#include <vector>
static std::function<long(long)> make_adder(long k){ return [k](long x){ return x+k; }; }
static std::function<long(long)> compose(std::function<long(long)> a, std::function<long(long)> b){
  return [a,b](long x){ return a(b(x)); };
}
int main(){
  auto f = compose(make_adder(9808%13), make_adder(100));
  auto g = compose(f, [](long x){return x*2;});
  long s=0; for(long i=0;i<8;i++) s += g(i);
  printf("%ld\n", s);
  return 0;
}
