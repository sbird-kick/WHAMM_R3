#include <map>
#include <string>
#include <cstdio>
struct Handler { virtual int handle(int x) const = 0; virtual ~Handler(){} };
struct Doubler : Handler { int handle(int x) const override { return x*2; } };
struct Squarer : Handler { int handle(int x) const override { return x*x; } };
struct Negator : Handler { int handle(int x) const override { return -x; } };
int main(){
    Doubler d; Squarer s; Negator n;
    std::map<std::string, Handler*> table = {{"double",&d},{"square",&s},{"neg",&n}};
    const char* seq[] = {"double","square","neg","double","neg"};
    int v = 3;
    for (auto name : seq) v = table[name]->handle(v);
    printf("v=%d\n", v);
    return 0;
}
