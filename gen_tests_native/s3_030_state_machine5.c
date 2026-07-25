#include <stdio.h>

typedef int (*trans_t)(int);

static int st5_0(int in) { return (in + 0 * 3 + 5) % 8; }
static int st5_1(int in) { return (in + 1 * 3 + 5) % 8; }
static int st5_2(int in) { return (in + 2 * 3 + 5) % 8; }
static int st5_3(int in) { return (in + 3 * 3 + 5) % 8; }
static int st5_4(int in) { return (in + 4 * 3 + 5) % 8; }
static int st5_5(int in) { return (in + 5 * 3 + 5) % 8; }
static int st5_6(int in) { return (in + 6 * 3 + 5) % 8; }
static int st5_7(int in) { return (in + 7 * 3 + 5) % 8; }

static trans_t trans_5[8] = { st5_0, st5_1, st5_2, st5_3, st5_4, st5_5, st5_6, st5_7 };

int main(void) {
    int state = 5;
    unsigned s = 2998;
    long path = 0;
    for (int i = 0; i < 29; i++) {
        s = (s * 1103515245u + 12345u) & 0x7fffffffu;
        int input = (int)(s % 251);
        state = trans_5[state](input);
        path = path * 31 + state;
        if (path > 1000000000L || path < -1000000000L) path %= 100003;
    }
    printf("F5 state=%d path=%ld\n", state, path);
    return 0;
}
