#include <stdio.h>

typedef struct { int *p; int v; } Node;
int main() {
    printf("start %s %d\n", "s1_ptr_struct_swap", 111);
    int x = 31, y = 11;
    Node n1 = { &x, 1 };
    Node n2 = { &y, 2 };
    Node tmp = n1;
    n1 = n2;
    n2 = tmp;
    int ok = (*n1.p == y) && (*n2.p == x);
    return !ok;
}
