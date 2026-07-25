#include <stdio.h>

/* tokens: 0..9 => push literal, 10=+ 11=- 12=* 13=max 14=min */
static int eval_rpn_1(const unsigned char *toks, int n) {
    int stack[64];
    int sp = 0;
    for (int i = 0; i < n; i++) {
        int t = toks[i];
        switch (t) {
            case 10: if (sp >= 2) { int b=stack[--sp], a=stack[--sp]; stack[sp++] = a + b; } break;
            case 11: if (sp >= 2) { int b=stack[--sp], a=stack[--sp]; stack[sp++] = a - b; } break;
            case 12: if (sp >= 2) { int b=stack[--sp], a=stack[--sp]; stack[sp++] = ((a % 100) * (b % 100)); } break;
            case 13: if (sp >= 2) { int b=stack[--sp], a=stack[--sp]; stack[sp++] = a > b ? a : b; } break;
            case 14: if (sp >= 2) { int b=stack[--sp], a=stack[--sp]; stack[sp++] = a < b ? a : b; } break;
            default:
                if (sp < 63) stack[sp++] = t;
                break;
        }
    }
    return sp > 0 ? stack[sp - 1] : -1;
}

int main(void) {
    unsigned char toks[12];
    unsigned s = 667;
    for (int i = 0; i < 12; i++) {
        s = (s * 1103515245u + 12345u) & 0x7fffffffu;
        int v = (int)(s % 15);
        toks[i] = (unsigned char)v;
    }
    /* ensure enough literals up front so ops have operands */
    toks[0] = 3; toks[1] = 7;
    int r = eval_rpn_1(toks, 12);
    printf("H1 result=%d\n", r);
    return 0;
}
