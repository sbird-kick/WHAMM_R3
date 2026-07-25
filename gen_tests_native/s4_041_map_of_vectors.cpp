#include <map>
#include <vector>
#include <cstdio>
int main(){
    std::map<int,std::vector<int>> m;
    for (int i=0;i<30;i++) m[i%5].push_back(i);
    long s=0;
    for (auto &p : m) for (int x : p.second) s = s*3 + x;
    printf("s=%ld groups=%zu\n", s, m.size());
    return 0;
}
