#include <queue>
#include <vector>
#include <functional>
#include <cstdio>
int main(){
    std::priority_queue<int, std::vector<int>, std::greater<int>> pq;
    int vals[] = {44,3,17,90,4,62,8,71,29};
    for (int v : vals) pq.push(v);
    long s=0;
    while (!pq.empty()) { s = s*7 + pq.top(); pq.pop(); }
    printf("s=%ld\n", s);
    return 0;
}
