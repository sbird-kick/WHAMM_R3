#include <stdio.h>

static int run_3(const unsigned char *prog, int len) {
    long acc = 1;
    for (int i = 0; i < len; i++) {
        int op = prog[i];
        switch (op % 10) {
        case 0: acc = acc + (op * 1); break;
        case 1: acc = acc - (op * 2); break;
        case 2: acc = acc * (op * 3); break;
        case 3: acc = acc ^ (op * 4); break;
        case 4: acc = acc & (op * 5); break;
        case 5: acc = acc | (op * 1); break;
        case 6: acc = acc + (op * 2); break;
        case 7: acc = acc - (op * 3); break;
        case 8: acc = acc + (op * 4); break;
        case 9: acc = acc - (op * 5); break;
        default: acc += 1; break;
        }
        if (acc > 1000000 || acc < -1000000) acc %= 997;
    }
    return (int)acc;
}

int main(void) {
    unsigned char prog[34];
    unsigned s = 1666;
    for (int i = 0; i < 34; i++) {
        s = (s * 1103515245u + 12345u) & 0x7fffffffu;
        prog[i] = (unsigned char)(s % 20);
    }
    int r = run_3(prog, 34);
    printf("B3 result=%d\n", r);
    return 0;
}
