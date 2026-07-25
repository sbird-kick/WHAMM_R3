#include <stdio.h>

static int pool[10];
typedef struct { int *base; int len; } View;
int main() {
    printf("start %s %d\n", "s1_struct_with_ptr_member", 111);
    int n = 10;
    for (int i = 0; i < n; i++) pool[i] = i * 2;
    View v1 = { pool, n };
    View v2 = v1;
    int sum = 0;
    for (int i = 0; i < v2.len; i++) sum += v2.base[i];
    int expect = 0;
    for (int i = 0; i < n; i++) expect += i * (2);
    return !(sum == expect);
}
