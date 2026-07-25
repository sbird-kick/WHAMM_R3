#include <cstdio>
#include <functional>
struct Counter { int n=9808%7; int operator()(int x){ n+=x; return n; } };
int main(){
  std::function<int(int)> c = Counter{};
  int acc=0; for(int i=0;i<10;i++) acc += c(i);
  std::function<long()> gen = [acc](){ return (long)acc*9808; };
  printf("%d %ld\n", acc, gen());
  return 0;
}
