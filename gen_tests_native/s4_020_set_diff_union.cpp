#include <set>
#include <algorithm>
#include <iterator>
#include <vector>
#include <cstdio>
int main(){
    std::set<int> a = {1,3,5,7,9,11,13};
    std::set<int> b = {3,7,11,15,19};
    std::vector<int> d, u;
    std::set_difference(a.begin(),a.end(),b.begin(),b.end(),std::back_inserter(d));
    std::set_union(a.begin(),a.end(),b.begin(),b.end(),std::back_inserter(u));
    printf("diff=%zu union=%zu\n", d.size(), u.size());
    return 0;
}
