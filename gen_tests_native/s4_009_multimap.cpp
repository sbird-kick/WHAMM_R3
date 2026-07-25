#include <map>
#include <cstdio>
int main(){
    std::multimap<int,int> mm;
    mm.insert({1,10}); mm.insert({1,20}); mm.insert({2,30}); mm.insert({1,40}); mm.insert({3,50});
    long s=0;
    auto range = mm.equal_range(1);
    for (auto it=range.first; it!=range.second; ++it) s += it->second;
    printf("s=%ld count=%zu\n", s, mm.count(1));
    return 0;
}
