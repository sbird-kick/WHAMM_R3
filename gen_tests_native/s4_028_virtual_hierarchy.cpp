#include <cstdio>
struct Base { virtual int val() const { return 1; } virtual ~Base(){} };
struct Mid : Base { int val() const override { return Base::val() + 10; } };
struct Leaf : Mid { int val() const override { return Mid::val() + 100; } };
int main(){
    Base b; Mid m; Leaf l;
    Base* arr[3] = {&b,&m,&l};
    long total=0;
    for (int i=0;i<3;i++) total += arr[i]->val();
    printf("total=%ld\n", total);
    return 0;
}
