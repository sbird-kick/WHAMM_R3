#include <cstdio>
#include <string>
#include <vector>
#include <algorithm>
int main(){
  std::vector<std::string> ws;
  const char* base="whammr3monitor";
  for(int i=0;i<26;i++){ std::string s; int seed=9808+i; for(int k=0;k<(i%7)+3;k++){ s+= (char)('a'+(seed%14)); s+=base[seed%14]; seed=seed*31+7; } ws.push_back(s); }
  std::sort(ws.begin(), ws.end());
  long h=0; for(auto&s:ws){ for(char c:s) h=(h*131+c)%1000000007; }
  printf("%zu %ld %s\n", ws.size(), h, ws.front().c_str());
  return 0;
}
