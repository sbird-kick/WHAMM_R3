#include <vector>
#include <algorithm>
#include <cstdio>
int main(){
    std::vector<int> v{9,4,4,4,2,2,7,7,1,3,3};
    std::stable_sort(v.begin(), v.end());
    long s=0; for(size_t i=0;i<v.size();++i) s += v[i]*(long)(i+1);
    printf("s=%ld\n", s);
    return 0;
}
