#include <cstdio>
static int seq = 0;
struct Base { int id; Base(int i):id(i){} virtual ~Base(){ seq = seq*10 + id; } };
struct Derived : Base { Derived(int i):Base(i){} ~Derived() override { seq = seq*10 + (id+1); } };
int main(){
    {
        Base* b = new Derived(1);
        delete b;
    }
    {
        Derived d(4);
    }
    printf("seq=%d\n", seq);
    return 0;
}
