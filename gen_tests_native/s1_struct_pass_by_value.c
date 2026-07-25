#include <stdio.h>

typedef struct { int a[7]; } Arr;
Arr make(int base) {
    Arr r;
    for (int i = 0; i < 7; i++) r.a[i] = base + i;
    return r;
}
int sum(Arr v) {
    int s = 0;
    for (int i = 0; i < 7; i++) s += v.a[i];
    return s;
}
int main() {
    printf("start %s %d\n", "s1_struct_pass_by_value", 111);
    Arr x = make(6);
    int s = sum(x);
    int expect = 0;
    for (int i = 0; i < 7; i++) expect += 6 + i;
    return !(s == expect);
}
