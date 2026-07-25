#include <map>
#include <cstdio>
int main(){
    std::map<int,int,std::greater<int>> m;
    for (int i=0;i<15;i++) m[i*3+444%7] = i*i;
    long s=0;
    for (auto it = m.rbegin(); it != m.rend(); ++it) s = s*5 + it->first + it->second;
    printf("s=%ld\n", s);
    return 0;
}
