#include <cstdio>
struct Base { int b; Base(int x):b(x){} virtual int who() const {return b;} virtual ~Base(){} };
struct L : virtual Base { L():Base(9808%50){} int who() const override {return b+1;} };
struct R : virtual Base { R():Base(9808%50){} int who() const override {return b+2;} };
struct D : L, R { D():Base(9808%50){} int who() const override {return b+100;} };
int main(){
  D d; Base* p=&d;
  L* l=&d; R* r=&d;
  printf("%d %d %d %d\n", p->who(), l->b, r->b, ((Base*)l)->b);
  return 0;
}
