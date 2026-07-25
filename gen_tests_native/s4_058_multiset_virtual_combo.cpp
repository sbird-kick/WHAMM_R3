#include <set>
#include <cstdio>
struct Ranker { virtual int rank(int x) const = 0; virtual ~Ranker(){} };
struct ModRank : Ranker { int m; ModRank(int m_):m(m_){} int rank(int x) const override { return x % m; } };
int main(){
    ModRank r(7);
    std::multiset<int> ms;
    int vals[] = {44,3,17,90,4,62,8,71,29,15,22};
    for (int v : vals) ms.insert(r.rank(v));
    long s=0;
    for (int x : ms) s = s*5+x;
    printf("s=%ld size=%zu\n", s, ms.size());
    return 0;
}
