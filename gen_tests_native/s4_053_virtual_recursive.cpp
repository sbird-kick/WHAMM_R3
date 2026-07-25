#include <cstdio>
struct Node { virtual int eval() const = 0; virtual ~Node(){} };
struct Leaf : Node { int v; Leaf(int v_):v(v_){} int eval() const override { return v; } };
struct Add : Node { Node *l,*r; Add(Node*a,Node*b):l(a),r(b){} int eval() const override { return l->eval()+r->eval(); } };
struct Mul : Node { Node *l,*r; Mul(Node*a,Node*b):l(a),r(b){} int eval() const override { return l->eval()*r->eval(); } };
int main(){
    Leaf a(4), b(7), c(3), d(9);
    Add s1(&a,&b);
    Mul m1(&c,&d);
    Add top(&s1,&m1);
    printf("result=%d\n", top.eval());
    return 0;
}
