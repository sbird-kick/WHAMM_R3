#include <stdio.h>

typedef int (*unop_t)(int);

static int f1_0(int x) { return (x * 1 + 1) % 8191; }
static int f1_1(int x) { return (x * 2 + 4) % 8191; }
static int f1_2(int x) { return (x * 3 + 7) % 8191; }
static int f1_3(int x) { return (x * 4 + 10) % 8191; }

static unop_t tbl_1[4] = { f1_0, f1_1, f1_2, f1_3 };

static int select_idx_1(int step) {
    switch (step % 4) {
        case 0: return 1;
        case 1: return 0;
        case 2: return 3;
        case 3: return 2;
        default: return 0;
    }
}

int main(void) {
    int x = 16;
    long acc = 0;
    for (int i = 0; i < 27; i++) {
        int sel = select_idx_1(i);
        unop_t f = tbl_1[sel];
        x = f(x);
        acc += x;
    }
    printf("E1 acc=%ld x=%d\n", acc, x);
    return 0;
}
