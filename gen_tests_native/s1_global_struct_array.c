#include <stdio.h>

#include <string.h>
typedef struct { int v; } W;
static W garr[19] = {0};
int main() {
    printf("start %s %d\n", "s1_global_struct_array", 111);
    int n = 19;
    for (int i = 0; i < n; i++) garr[i].v = i * i + 3;
    W local[20];
    memcpy(local, garr, n * sizeof(W));
    int sum = 0;
    for (int i = 0; i < n; i++) sum += local[i].v;
    int expect = 0;
    for (int i = 0; i < n; i++) expect += i*i + 3;
    return !(sum == expect);
}
