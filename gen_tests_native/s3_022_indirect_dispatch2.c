#include <stdio.h>

typedef int (*unop_t)(int);

static int f2_0(int x) { return (x * 1 + 1) % 8191; }
static int f2_1(int x) { return (x * 2 + 4) % 8191; }
static int f2_2(int x) { return (x * 3 + 7) % 8191; }
static int f2_3(int x) { return (x * 4 + 10) % 8191; }
static int f2_4(int x) { return (x * 5 + 13) % 8191; }

static unop_t tbl_2[5] = { f2_0, f2_1, f2_2, f2_3, f2_4 };

static int select_idx_2(int step) {
    switch (step % 5) {
        case 0: return 2;
        case 1: return 4;
        case 2: return 1;
        case 3: return 3;
        case 4: return 0;
        default: return 0;
    }
}

int main(void) {
    int x = 21;
    long acc = 0;
    for (int i = 0; i < 20; i++) {
        int sel = select_idx_2(i);
        unop_t f = tbl_2[sel];
        x = f(x);
        acc += x;
    }
    printf("E2 acc=%ld x=%d\n", acc, x);
    return 0;
}
