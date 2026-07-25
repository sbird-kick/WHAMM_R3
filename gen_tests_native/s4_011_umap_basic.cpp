#include <unordered_map>
#include <cstdio>
int main(){
    std::unordered_map<int,int> m;
    for (int i=0;i<44;i++) m[i] = (i*7) % 41;
    long s=0;
    for (int i=0;i<44;i++) s += m[i];
    printf("s=%ld size=%zu\n", s, m.size());
    return 0;
}
