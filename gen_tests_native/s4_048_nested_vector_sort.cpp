#include <vector>
#include <algorithm>
#include <cstdio>
int main(){
    std::vector<std::vector<int>> vv;
    int seed = 444;
    for (int i=0;i<6;i++) {
        std::vector<int> row;
        for (int j=0;j<5;j++) { seed=(seed*1103515245+12345)&0x7fffffff; row.push_back(seed%50); }
        vv.push_back(row);
    }
    std::sort(vv.begin(), vv.end(), [](const std::vector<int>&a, const std::vector<int>&b){
        int sa=0, sb=0;
        for (int x : a) sa += x;
        for (int x : b) sb += x;
        return sa < sb;
    });
    long s=0;
    for (auto &row : vv) for (int x : row) s = s*5+x;
    printf("s=%ld\n", s);
    return 0;
}
