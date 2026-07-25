#include <map>
#include <numeric>
#include <vector>
#include <cstdio>
int main(){
    std::map<int,int> m;
    for (int i=0;i<25;i++) m[i] = i*i % 44;
    std::vector<int> vals;
    for (auto &p : m) vals.push_back(p.second);
    long s = std::accumulate(vals.begin(), vals.end(), 0L);
    printf("s=%ld size=%zu\n", s, vals.size());
    return 0;
}
