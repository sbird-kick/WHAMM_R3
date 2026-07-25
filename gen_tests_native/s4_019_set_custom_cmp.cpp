#include <set>
#include <cstdio>
struct ByAbsMod { bool operator()(int a,int b) const { return (a%7) < (b%7) || ((a%7)==(b%7)&&a<b); } };
int main(){
    std::set<int,ByAbsMod> s;
    int vals[] = {14,3,21,8,44,10,17,29,5,63};
    for (int v : vals) s.insert(v);
    long total=0;
    for (int x : s) total = total*11 + x;
    printf("size=%zu total=%ld\n", s.size(), total);
    return 0;
}
