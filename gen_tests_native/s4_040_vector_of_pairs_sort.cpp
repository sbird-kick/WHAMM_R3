#include <vector>
#include <utility>
#include <algorithm>
#include <cstdio>
int main(){
    std::vector<std::pair<int,int>> v;
    int seed = 444;
    for (int i=0;i<12;i++) {
        seed = (seed*1103515245+12345)&0x7fffffff;
        v.push_back({seed%30, i});
    }
    std::sort(v.begin(), v.end());
    long s=0;
    for (auto &p : v) s = s*17 + p.first*100+p.second;
    printf("s=%ld\n", s);
    return 0;
}
