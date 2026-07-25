#include <stdio.h>

#include <string.h>
typedef struct { int x; int y; int z; } V3;
int main() {
    printf("start %s %d\n", "s1_struct_memcmp", 111);
    V3 a = { 1, 11, 21 };
    V3 b = a;
    b.y += 0;
    int eq = memcmp(&a, &b, sizeof(V3)) == 0;
    b.y += 1;
    int neq = memcmp(&a, &b, sizeof(V3)) != 0;
    return !(eq && neq);
}
