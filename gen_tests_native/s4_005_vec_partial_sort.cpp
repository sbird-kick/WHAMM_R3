#include <vector>
#include <algorithm>
#include <cstdio>
int main(){
    std::vector<int> v{55,12,88,3,44,29,6,71,18,90,2,63};
    std::partial_sort(v.begin(), v.begin()+4, v.end());
    long s=0; for(int x: v) s = s*7+x;
    printf("s=%ld\n", s);
    return 0;
}
