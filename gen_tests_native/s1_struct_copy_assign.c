#include <stdio.h>

typedef struct { int a; double b; char c[22]; } S;
int main() {
    printf("start %s %d\n", "s1_struct_copy_assign", 111);
    S x;
    x.a = 111;
    x.b = 3.5;
    for (int i = 0; i < 22; i++) x.c[i] = (char)i;
    S y;
    y = x;
    int ok = (y.a == x.a) && (y.b == x.b);
    for (int i = 0; i < 22; i++) if (y.c[i] != x.c[i]) ok = 0;
    return !ok;
}
