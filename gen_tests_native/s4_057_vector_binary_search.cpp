#include <vector>
#include <algorithm>
#include <cstdio>
int main(){
    std::vector<int> v;
    for (int i=0;i<44;i++) v.push_back(i*2);
    int found = 0;
    for (int q : {10, 21, 44, 87, 3}) {
        if (std::binary_search(v.begin(), v.end(), q)) found++;
    }
    auto it = std::lower_bound(v.begin(), v.end(), 50);
    printf("found=%d idx=%ld\n", found, (long)(it-v.begin()));
    return 0;
}
