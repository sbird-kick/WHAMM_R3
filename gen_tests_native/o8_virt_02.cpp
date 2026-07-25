#include <cstdio>
struct Visitor;
struct Node { virtual long accept(Visitor&) =0; virtual ~Node(){} };
struct Leaf; struct Branch;
struct Visitor { virtual long vl(Leaf&)=0; virtual long vb(Branch&)=0; virtual ~Visitor(){} };
struct Leaf : Node { long v; Leaf(long x):v(x){} long accept(Visitor&vi) override; };
struct Branch : Node { Node*a; Node*b; Branch(Node*x,Node*y):a(x),b(y){} long accept(Visitor&vi) override; };
struct Sum : Visitor { long vl(Leaf&l) override{return l.v;} long vb(Branch&b) override{return b.a->accept(*this)+b.b->accept(*this);} };
long Leaf::accept(Visitor&vi){ return vi.vl(*this); }
long Branch::accept(Visitor&vi){ return vi.vb(*this); }
int main(){
  Leaf a(9808%30), b(5), c(7);
  Branch x(&a,&b), y(&x,&c);
  Sum s; printf("%ld\n", y.accept(s));
  return 0;
}
