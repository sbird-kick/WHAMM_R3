#include <stdio.h>

typedef struct { int x, y; } Pt;
int main() {
    printf("start %s %d\n", "s1_struct_array_copy", 111);
    Pt a[20];
    Pt b[20];
    int n = 20;
    for (int i = 0; i < n; i++) { a[i].x = i; a[i].y = i * 2; }
    for (int i = 0; i < n; i++) b[i] = a[i];
    int ok = 1;
    for (int i = 0; i < n; i++) if (b[i].x != a[i].x || b[i].y != a[i].y) ok = 0;
    return !ok;
}
