#include <stdio.h>

static int run_2(const unsigned char *prog, int len) {
    long acc = 1;
    for (int i = 0; i < len; i++) {
        int op = prog[i];
        switch (op % 8) {
        case 0: acc = acc + (op * 1); break;
        case 1: acc = acc - (op * 2); break;
        case 2: acc = acc * (op * 3); break;
        case 3: acc = acc ^ (op * 4); break;
        case 4: acc = acc & (op * 5); break;
        case 5: acc = acc | (op * 1); break;
        case 6: acc = acc + (op * 2); break;
        case 7: acc = acc - (op * 3); break;
        default: acc += 1; break;
        }
        if (acc > 1000000 || acc < -1000000) acc %= 997;
    }
    return (int)acc;
}

int main(void) {
    unsigned char prog[21];
    unsigned s = 1333;
    for (int i = 0; i < 21; i++) {
        s = (s * 1103515245u + 12345u) & 0x7fffffffu;
        prog[i] = (unsigned char)(s % 16);
    }
    int r = run_2(prog, 21);
    printf("B2 result=%d\n", r);
    return 0;
}
