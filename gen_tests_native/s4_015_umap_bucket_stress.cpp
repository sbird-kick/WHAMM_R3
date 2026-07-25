#include <unordered_map>
#include <cstdio>
int main(){
    std::unordered_map<long,long> m;
    m.reserve(8);
    for (long i=0;i<60;i++) m[i*13 % 97] += i;
    long s=0;
    for (auto &p : m) s += p.first + p.second;
    printf("s=%ld size=%zu\n", s, m.size());
    return 0;
}
