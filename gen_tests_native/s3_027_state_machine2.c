#include <stdio.h>

typedef int (*trans_t)(int);

static int st2_0(int in) { return (in + 0 * 3 + 2) % 5; }
static int st2_1(int in) { return (in + 1 * 3 + 2) % 5; }
static int st2_2(int in) { return (in + 2 * 3 + 2) % 5; }
static int st2_3(int in) { return (in + 3 * 3 + 2) % 5; }
static int st2_4(int in) { return (in + 4 * 3 + 2) % 5; }

static trans_t trans_2[5] = { st2_0, st2_1, st2_2, st2_3, st2_4 };

int main(void) {
    int state = 2;
    unsigned s = 1999;
    long path = 0;
    for (int i = 0; i < 32; i++) {
        s = (s * 1103515245u + 12345u) & 0x7fffffffu;
        int input = (int)(s % 251);
        state = trans_2[state](input);
        path = path * 31 + state;
        if (path > 1000000000L || path < -1000000000L) path %= 100003;
    }
    printf("F2 state=%d path=%ld\n", state, path);
    return 0;
}
