#include <stdio.h>

typedef int (*trans_t)(int);

static int st4_0(int in) { return (in + 0 * 3 + 4) % 7; }
static int st4_1(int in) { return (in + 1 * 3 + 4) % 7; }
static int st4_2(int in) { return (in + 2 * 3 + 4) % 7; }
static int st4_3(int in) { return (in + 3 * 3 + 4) % 7; }
static int st4_4(int in) { return (in + 4 * 3 + 4) % 7; }
static int st4_5(int in) { return (in + 5 * 3 + 4) % 7; }
static int st4_6(int in) { return (in + 6 * 3 + 4) % 7; }

static trans_t trans_4[7] = { st4_0, st4_1, st4_2, st4_3, st4_4, st4_5, st4_6 };

int main(void) {
    int state = 4;
    unsigned s = 2665;
    long path = 0;
    for (int i = 0; i < 20; i++) {
        s = (s * 1103515245u + 12345u) & 0x7fffffffu;
        int input = (int)(s % 251);
        state = trans_4[state](input);
        path = path * 31 + state;
        if (path > 1000000000L || path < -1000000000L) path %= 100003;
    }
    printf("F4 state=%d path=%ld\n", state, path);
    return 0;
}
