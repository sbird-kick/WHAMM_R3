#include <set>
#include <algorithm>
#include <iterator>
#include <vector>
#include <cstdio>
int main(){
    std::set<int> a = {2,4,6,8,10,12,14,16,18,20};
    std::set<int> b = {4,8,12,16,20,24,28};
    std::vector<int> out;
    std::set_intersection(a.begin(),a.end(),b.begin(),b.end(),std::back_inserter(out));
    long s=0; for(int x: out) s = s*5+x;
    printf("count=%zu s=%ld\n", out.size(), s);
    return 0;
}
