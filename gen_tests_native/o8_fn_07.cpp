#include <cstdio>
#include <functional>
#include <vector>
int main(){
  std::vector<std::function<long(long)>> pipe;
  int seed=9808;
  for(int i=0;i<6;i++){ long k=seed%20; pipe.push_back([k,i](long x){ return i%2? x+k : x*2-k; }); seed=seed*31+1; }
  long v=9808%100;
  for(auto&f:pipe) v=f(v);
  printf("%ld\n", v);
  return 0;
}
