#include <vector>
#include <algorithm>
#include <cstdio>
int main(){
    std::vector<int> v;
    for (int i=0;i<44;i++) v.push_back(i);
    v.erase(std::remove_if(v.begin(), v.end(), [](int x){ return x%3==0; }), v.end());
    long s=0;
    for (int x : v) s = s*3+x;
    printf("size=%zu s=%ld\n", v.size(), s);
    return 0;
}
