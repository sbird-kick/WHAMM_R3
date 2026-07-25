#include <stdio.h>

typedef int (*unop_t)(int);

static int f5_0(int x) { return (x * 1 + 1) % 8191; }
static int f5_1(int x) { return (x * 2 + 4) % 8191; }
static int f5_2(int x) { return (x * 3 + 7) % 8191; }
static int f5_3(int x) { return (x * 4 + 10) % 8191; }
static int f5_4(int x) { return (x * 5 + 13) % 8191; }
static int f5_5(int x) { return (x * 6 + 16) % 8191; }
static int f5_6(int x) { return (x * 7 + 19) % 8191; }
static int f5_7(int x) { return (x * 8 + 22) % 8191; }

static unop_t tbl_5[8] = { f5_0, f5_1, f5_2, f5_3, f5_4, f5_5, f5_6, f5_7 };

static int select_idx_5(int step) {
    switch (step % 8) {
        case 0: return 5;
        case 1: return 4;
        case 2: return 3;
        case 3: return 2;
        case 4: return 1;
        case 5: return 0;
        case 6: return 7;
        case 7: return 6;
        default: return 0;
    }
}

int main(void) {
    int x = 36;
    long acc = 0;
    for (int i = 0; i < 23; i++) {
        int sel = select_idx_5(i);
        unop_t f = tbl_5[sel];
        x = f(x);
        acc += x;
    }
    printf("E5 acc=%ld x=%d\n", acc, x);
    return 0;
}
