#include <stdio.h>

typedef struct { int sum; int count; } Acc;
int main() {
    printf("start %s %d\n", "s1_accumulator_struct_copy", 111);
    Acc history[9];
    Acc cur = {0, 0};
    int n = 9;
    for (int i = 0; i < n; i++) {
        cur.sum += i + 3;
        cur.count += 1;
        history[i] = cur;
    }
    int ok = (history[n-1].count == n);
    int expect = 0;
    for (int i = 0; i < n; i++) expect += i + 3;
    ok = ok && (history[n-1].sum == expect);
    return !ok;
}
