#include <cstdio>
#include <new>
#include <cstddef>
struct Widget { int id; Widget(int i):id(i){} virtual int cost() const { return id*10; } virtual ~Widget(){} };
struct Pro : Widget { int extra; Pro():Widget(0){} int cost() const override { return id*10+extra; } };
int main(){
  alignas(16) unsigned char buf[128];
  Widget* w=new(buf) Widget{9808%40};
  Pro* p=new(buf+64) Pro; p->id=7; p->extra=9808%15;
  Widget* arr[2]={w,p};
  long s=0; for(auto*x:arr) s=s*100+x->cost();
  printf("%ld\n", s);
  return 0;
}
