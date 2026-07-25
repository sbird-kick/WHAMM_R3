#include <stdio.h>

#include <string.h>
typedef struct { int a, b; } P;
int main() {
    printf("start %s %d\n", "s1_struct_array_memmove", 111);
    int n = 16;
    P arr[20];
    for (int i = 0; i < n; i++) { arr[i].a = i; arr[i].b = i * 2; }
    memmove(&arr[1], &arr[0], (n - 1) * sizeof(P));
    int ok = 1;
    for (int i = 1; i < n; i++) if (arr[i].a != i - 1) ok = 0;
    return !ok;
}
