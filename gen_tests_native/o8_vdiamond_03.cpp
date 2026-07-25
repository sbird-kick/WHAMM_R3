#include <cstdio>
struct Animal { int id; Animal(int i):id(i){} virtual int sound() const=0; virtual ~Animal(){} };
struct Legged : virtual Animal { int legs; Legged(int l):Animal(9808%20),legs(l){} };
struct Winged : virtual Animal { int wings; Winged(int w):Animal(9808%20),wings(w){} };
struct Griffin : Legged, Winged {
  Griffin():Animal(9808%20),Legged(4),Winged(2){}
  int sound() const override { return id*1000 + legs*10 + wings; }
};
int main(){
  Griffin g; Animal* a=&g;
  printf("%d %d %d\n", a->sound(), g.legs, g.wings);
  return 0;
}
