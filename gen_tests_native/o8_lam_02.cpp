#include <cstdio>
#include <vector>
#include <algorithm>
int main(){
  std::vector<int> v(40);
  int seed=9808; for(auto&x:v){ x=seed%200-100; seed=seed*1103515245+12345; }
  int pivot=9808%100-50;
  auto cnt=std::count_if(v.begin(),v.end(),[pivot](int x){return x>pivot;});
  std::sort(v.begin(),v.end(),[](int a,int b){return (a*a)<(b*b);});
  long h=0; for(int x:v) h=h*13+x;
  printf("%ld %ld\n", (long)cnt, h);
  return 0;
}
