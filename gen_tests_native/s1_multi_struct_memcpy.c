#include <stdio.h>

#include <string.h>
typedef struct { int id; float val; } Rec;
int main() {
    printf("start %s %d\n", "s1_multi_struct_memcpy", 111);
    Rec arr[4];
    Rec copy[4];
    int n = 4;
    for (int i = 0; i < n; i++) { arr[i].id = i; arr[i].val = i * 1.5f; }
    memcpy(copy, arr, sizeof(arr));
    int ok = 1;
    for (int i = 0; i < n; i++) if (copy[i].id != arr[i].id) ok = 0;
    return !ok;
}
