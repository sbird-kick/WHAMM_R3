#include <cstdio>
#include <functional>
#include <map>
int main(){
  std::map<int, std::function<int(int,int)>> ops;
  ops[0]=[](int a,int b){return a+b;};
  ops[1]=[](int a,int b){return a-b;};
  ops[2]=[](int a,int b){return a*b;};
  int seed=9808; long s=0;
  for(int i=0;i<12;i++){ int op=i%3; s=s*5 + ops[op](seed%50, i+1); seed=seed*1103515245+12345; }
  printf("%ld\n", s);
  return 0;
}
