#include <stdio.h>

typedef struct { int a; } L1;
typedef struct { L1 l1; int b; } L2;
typedef struct { L2 l2; int c; } L3;
int main() {
    printf("start %s %d\n", "s1_deep_nested_struct", 111);
    L3 x;
    x.l2.l1.a = 1;
    x.l2.b = 11;
    x.c = 21;
    L3 y = x;
    int ok = (y.l2.l1.a == x.l2.l1.a) && (y.l2.b == x.l2.b) && (y.c == x.c);
    return !ok;
}
