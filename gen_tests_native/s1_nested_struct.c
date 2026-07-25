#include <stdio.h>

typedef struct { int a; int b; } Inner;
typedef struct { Inner in; double d; } Outer;
int main() {
    printf("start %s %d\n", "s1_nested_struct", 111);
    Outer o1 = { { 11, 21 }, 2.25 };
    Outer o2;
    o2 = o1;
    int ok = (o2.in.a == o1.in.a) && (o2.in.b == o1.in.b) && (o2.d == o1.d);
    return !ok;
}
