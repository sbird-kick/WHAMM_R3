#include <stdio.h>

typedef int (*unop_t)(int);

static int f3_0(int x) { return (x * 1 + 1) % 8191; }
static int f3_1(int x) { return (x * 2 + 4) % 8191; }
static int f3_2(int x) { return (x * 3 + 7) % 8191; }
static int f3_3(int x) { return (x * 4 + 10) % 8191; }
static int f3_4(int x) { return (x * 5 + 13) % 8191; }
static int f3_5(int x) { return (x * 6 + 16) % 8191; }

static unop_t tbl_3[6] = { f3_0, f3_1, f3_2, f3_3, f3_4, f3_5 };

static int select_idx_3(int step) {
    switch (step % 6) {
        case 0: return 3;
        case 1: return 4;
        case 2: return 5;
        case 3: return 0;
        case 4: return 1;
        case 5: return 2;
        default: return 0;
    }
}

int main(void) {
    int x = 26;
    long acc = 0;
    for (int i = 0; i < 25; i++) {
        int sel = select_idx_3(i);
        unop_t f = tbl_3[sel];
        x = f(x);
        acc += x;
    }
    printf("E3 acc=%ld x=%d\n", acc, x);
    return 0;
}
