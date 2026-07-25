#include <map>
#include <cstdio>
int main(){
    std::map<int,int> m;
    int seed = 444;
    for (int i=0;i<20;i++){
        seed = (seed*1103515245 + 12345) & 0x7fffffff;
        m[seed % 50] += (seed % 7) + 1;
    }
    long s=0;
    for (auto &p : m) s = s*3 + p.first*10 + p.second;
    printf("size=%zu s=%ld\n", m.size(), s);
    return 0;
}
