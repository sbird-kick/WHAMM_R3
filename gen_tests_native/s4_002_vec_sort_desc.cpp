#include <vector>
#include <algorithm>
#include <cstdio>
struct Cmp { bool operator()(int a,int b) const { return a>b; } };
int main(){
    std::vector<int> v{5,44,12,9,63,21,8,77,1,40,4};
    std::sort(v.begin(), v.end(), Cmp());
    long s=0; for(int x: v) s = s*17+x;
    printf("s=%ld top=%d\n", s, v[0]);
    return 0;
}
