#include <stdio.h>

typedef int (*trans_t)(int);

static int st1_0(int in) { return (in + 0 * 3 + 1) % 4; }
static int st1_1(int in) { return (in + 1 * 3 + 1) % 4; }
static int st1_2(int in) { return (in + 2 * 3 + 1) % 4; }
static int st1_3(int in) { return (in + 3 * 3 + 1) % 4; }

static trans_t trans_1[4] = { st1_0, st1_1, st1_2, st1_3 };

int main(void) {
    int state = 1;
    unsigned s = 1666;
    long path = 0;
    for (int i = 0; i < 23; i++) {
        s = (s * 1103515245u + 12345u) & 0x7fffffffu;
        int input = (int)(s % 251);
        state = trans_1[state](input);
        path = path * 31 + state;
        if (path > 1000000000L || path < -1000000000L) path %= 100003;
    }
    printf("F1 state=%d path=%ld\n", state, path);
    return 0;
}
