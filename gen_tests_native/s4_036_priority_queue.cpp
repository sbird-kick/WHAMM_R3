#include <queue>
#include <vector>
#include <cstdio>
int main(){
    std::priority_queue<int> pq;
    int seed=444;
    for (int i=0;i<20;i++){ seed=(seed*1103515245+12345)&0x7fffffff; pq.push(seed%100); }
    long s=0;
    while (!pq.empty()) { s = s*3 + pq.top(); pq.pop(); }
    printf("s=%ld\n", s);
    return 0;
}
