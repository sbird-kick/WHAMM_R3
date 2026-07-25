#include <stdio.h>

typedef int (*trans_t)(int);

static int st3_0(int in) { return (in + 0 * 3 + 3) % 6; }
static int st3_1(int in) { return (in + 1 * 3 + 3) % 6; }
static int st3_2(int in) { return (in + 2 * 3 + 3) % 6; }
static int st3_3(int in) { return (in + 3 * 3 + 3) % 6; }
static int st3_4(int in) { return (in + 4 * 3 + 3) % 6; }
static int st3_5(int in) { return (in + 5 * 3 + 3) % 6; }

static trans_t trans_3[6] = { st3_0, st3_1, st3_2, st3_3, st3_4, st3_5 };

int main(void) {
    int state = 3;
    unsigned s = 2332;
    long path = 0;
    for (int i = 0; i < 26; i++) {
        s = (s * 1103515245u + 12345u) & 0x7fffffffu;
        int input = (int)(s % 251);
        state = trans_3[state](input);
        path = path * 31 + state;
        if (path > 1000000000L || path < -1000000000L) path %= 100003;
    }
    printf("F3 state=%d path=%ld\n", state, path);
    return 0;
}
