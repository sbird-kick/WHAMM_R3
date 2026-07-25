#include <cstdio>
struct A { int v; A(int x):v(x){} virtual int g() const {return v*2;} virtual ~A(){} };
struct B1 : virtual A { B1():A(9808%30){} int g() const override {return v*3;} };
struct B2 : virtual A { B2():A(9808%30){} int g() const override {return v*5;} };
struct C : B1, B2 { C():A(9808%30){} int g() const override {return B1::g()+B2::g();} };
int main(){
  C c; A* a=&c;
  int s=0; A* arr[3]={ &c, (A*)(B1*)&c, (A*)(B2*)&c };
  for(A* x:arr) s = s*7 + x->g();
  printf("%d %d\n", a->g(), s);
  return 0;
}
