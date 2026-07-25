#include <vector>
#include <algorithm>
#include <cstdio>
int main(){
    std::vector<int> v{44,4,17,90,3,62,8,71,29,15};
    std::sort(v.begin(), v.end(), [](int a,int b){return a<b;});
    long s=0; for(int x: v) s = s*31+x;
    printf("sum=%ld first=%d last=%d\n", s, v.front(), v.back());
    return 0;
}
