#include <unordered_map>
#include <set>
#include <cstdio>
int main(){
    std::unordered_map<int,std::set<int>> m;
    for (int i=0;i<40;i++) m[i%6].insert(i%13);
    long total=0;
    for (auto &p : m) {
        total += p.first;
        for (int x : p.second) total += x;
    }
    printf("total=%ld groups=%zu\n", total, m.size());
    return 0;
}
