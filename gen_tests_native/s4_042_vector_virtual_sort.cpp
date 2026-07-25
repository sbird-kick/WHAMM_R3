#include <vector>
#include <algorithm>
#include <cstdio>
struct Scorer { virtual int score(int x) const = 0; virtual ~Scorer(){} };
struct Neg : Scorer { int score(int x) const override { return -x; } };
struct Sqr : Scorer { int score(int x) const override { return x*x % 97; } };
int main(){
    std::vector<int> v{9,4,17,2,44,8,63,1,29};
    Neg neg; Sqr sqr;
    Scorer* s = (v.size() % 2 == 0) ? (Scorer*)&neg : (Scorer*)&sqr;
    std::sort(v.begin(), v.end(), [s](int a, int b){ return s->score(a) < s->score(b); });
    long sum=0;
    for (int x : v) sum = sum*13 + x;
    printf("sum=%ld\n", sum);
    return 0;
}
