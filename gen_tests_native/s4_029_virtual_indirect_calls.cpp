#include <cstdio>
struct Op { virtual int apply(int x) const = 0; virtual ~Op(){} };
struct AddOp : Op { int n; AddOp(int n_):n(n_){} int apply(int x) const override { return x+n; } };
struct MulOp : Op { int n; MulOp(int n_):n(n_){} int apply(int x) const override { return x*n; } };
int compute(Op* ops[], int count, int start) {
    int v = start;
    for (int i=0;i<count;i++) v = ops[i]->apply(v);
    return v;
}
int main(){
    AddOp a1(4), a2(44); MulOp m1(3), m2(7);
    Op* ops[4] = {&a1,&m1,&a2,&m2};
    int r = compute(ops, 4, 2);
    printf("result=%d\n", r);
    return 0;
}
