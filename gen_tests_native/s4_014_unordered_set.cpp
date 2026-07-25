#include <unordered_set>
#include <cstdio>
int main(){
    std::unordered_set<int> s;
    int seed=444;
    for (int i=0;i<40;i++){
        seed = (seed*1103515245+12345)&0x7fffffff;
        s.insert(seed % 25);
    }
    long total=0;
    for (int x : s) total += x;
    printf("size=%zu total=%ld\n", s.size(), total);
    return 0;
}
