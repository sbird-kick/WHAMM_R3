#include <cstdio>
#include <vector>
#include <memory>
struct Expr { virtual long ev() const=0; virtual ~Expr(){} };
struct Lit : Expr { long v; Lit(long x):v(x){} long ev()const override{return v;} };
struct Bin : Expr { char op; Expr*l; Expr*r; Bin(char o,Expr*a,Expr*b):op(o),l(a),r(b){}
  long ev()const override{ long x=l->ev(),y=r->ev(); return op=='+'?x+y:op=='*'?x*y:x-y; } };
int main(){
  Lit a(9808%20), b(5), c(3);
  Bin m('*',&a,&b), s('+',&m,&c), d('-',&s,&a);
  printf("%ld %ld %ld\n", m.ev(), s.ev(), d.ev());
  return 0;
}
