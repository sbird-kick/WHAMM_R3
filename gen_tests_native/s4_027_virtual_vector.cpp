#include <vector>
#include <cstdio>
struct Animal { virtual int legs() const = 0; virtual ~Animal(){} };
struct Dog : Animal { int legs() const override { return 4; } };
struct Bird : Animal { int legs() const override { return 2; } };
struct Snake : Animal { int legs() const override { return 0; } };
int main(){
    std::vector<Animal*> v;
    Dog d1,d2; Bird b1; Snake s1; Dog d3; Bird b2;
    v.push_back(&d1); v.push_back(&b1); v.push_back(&s1);
    v.push_back(&d2); v.push_back(&b2); v.push_back(&d3);
    long total=0;
    for (auto a : v) total += a->legs();
    printf("total=%ld count=%zu\n", total, v.size());
    return 0;
}
