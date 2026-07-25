#include <cstdio>
#include <functional>
#include <vector>
int main(){
  std::vector<int> data;
  int seed=9808;
  auto push=[&](int k){ for(int i=0;i<k;i++){ data.push_back(seed%1000); seed=seed*1103515245+12345; } };
  std::function<long()> hash=[&](){ long h=1469598103934665603UL & 0x7fffffff; for(int x:data) h=(h^x)*16777619 & 0x7fffffff; return h; };
  push(200); push(300);
  printf("%zu %ld\n", data.size(), hash());
  return 0;
}
