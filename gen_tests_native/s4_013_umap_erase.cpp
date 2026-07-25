#include <unordered_map>
#include <cstdio>
int main(){
    std::unordered_map<int,long> m;
    for (int i=0;i<30;i++) m[i] = i*i;
    for (int i=0;i<30;i+=3) m.erase(i);
    long s=0;
    for (auto &p : m) s += p.second;
    printf("s=%ld size=%zu\n", s, m.size());
    return 0;
}
