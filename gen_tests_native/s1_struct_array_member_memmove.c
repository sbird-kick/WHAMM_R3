#include <stdio.h>

#include <string.h>
typedef struct { int vals[14]; int len; } Buf;
int main() {
    printf("start %s %d\n", "s1_struct_array_member_memmove", 111);
    Buf b;
    b.len = 14;
    for (int i = 0; i < b.len; i++) b.vals[i] = i;
    memmove(&b.vals[1], &b.vals[0], (b.len - 1) * sizeof(int));
    int ok = 1;
    for (int i = 1; i < b.len; i++) if (b.vals[i] != i - 1) ok = 0;
    return !ok;
}
