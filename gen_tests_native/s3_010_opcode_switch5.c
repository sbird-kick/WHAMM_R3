#include <stdio.h>

static int run_5(const unsigned char *prog, int len) {
    long acc = 1;
    for (int i = 0; i < len; i++) {
        int op = prog[i];
        switch (op % 14) {
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
        case 10: acc = acc * (op * 1); break;
        case 11: acc = acc ^ (op * 2); break;
        case 12: acc = acc & (op * 3); break;
        case 13: acc = acc | (op * 4); break;
        default: acc += 1; break;
        }
        if (acc > 1000000 || acc < -1000000) acc %= 997;
    }
    return (int)acc;
}

int main(void) {
    unsigned char prog[20];
    unsigned s = 2332;
    for (int i = 0; i < 20; i++) {
        s = (s * 1103515245u + 12345u) & 0x7fffffffu;
        prog[i] = (unsigned char)(s % 28);
    }
    int r = run_5(prog, 20);
    printf("B5 result=%d\n", r);
    return 0;
}
