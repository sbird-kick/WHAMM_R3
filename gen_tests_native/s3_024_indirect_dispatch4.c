#include <stdio.h>

typedef int (*unop_t)(int);

static int f4_0(int x) { return (x * 1 + 1) % 8191; }
static int f4_1(int x) { return (x * 2 + 4) % 8191; }
static int f4_2(int x) { return (x * 3 + 7) % 8191; }
static int f4_3(int x) { return (x * 4 + 10) % 8191; }
static int f4_4(int x) { return (x * 5 + 13) % 8191; }
static int f4_5(int x) { return (x * 6 + 16) % 8191; }
static int f4_6(int x) { return (x * 7 + 19) % 8191; }

static unop_t tbl_4[7] = { f4_0, f4_1, f4_2, f4_3, f4_4, f4_5, f4_6 };

static int select_idx_4(int step) {
    switch (step % 7) {
        case 0: return 4;
        case 1: return 4;
        case 2: return 4;
        case 3: return 4;
        case 4: return 4;
        case 5: return 4;
        case 6: return 4;
        default: return 0;
    }
}

int main(void) {
    int x = 31;
    long acc = 0;
    for (int i = 0; i < 18; i++) {
        int sel = select_idx_4(i);
        unop_t f = tbl_4[sel];
        x = f(x);
        acc += x;
    }
    printf("E4 acc=%ld x=%d\n", acc, x);
    return 0;
}
