#include <set>
#include <cstdio>
int main(){
    std::set<int> s;
    for (int i=0;i<50;i+=3) s.insert(i);
    auto lo = s.lower_bound(20);
    auto hi = s.upper_bound(40);
    long total=0;
    int count=0;
    for (auto it=lo; it!=hi; ++it) { total += *it; count++; }
    printf("count=%d total=%ld\n", count, total);
    return 0;
}
