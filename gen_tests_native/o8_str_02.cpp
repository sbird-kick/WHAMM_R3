#include <cstdio>
#include <string>
#include <map>
int main(){
  std::map<std::string,int> freq;
  const char* txt="the quick brown fox the lazy dog the fox 9808";
  std::string cur;
  for(const char*p=txt; ; ++p){ if(*p==' '||*p==0){ if(!cur.empty()){freq[cur]++; cur.clear();} if(*p==0) break; } else cur+=*p; }
  long h=0; for(auto&kv:freq) h = h*37 + kv.second*100 + kv.first.size();
  printf("%zu %ld\n", freq.size(), h);
  return 0;
}
