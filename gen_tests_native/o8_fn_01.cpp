#include <cstdio>
#include <functional>
#include <vector>
int main(){
  int cap = 9808 % 100;
  std::function<int(int)> f = [cap](int x){ return x*x + cap; };
  std::function<int(int)> g = [&](int x){ return f(x) - cap/2; };
  std::vector<std::function<int(int)>> fs = { f, g, [](int x){return x+1;} };
  long s=0; for(auto& h:fs) for(int i=0;i<5;i++) s = s*3 + h(i);
  printf("%ld\n", s);
  return 0;
}
