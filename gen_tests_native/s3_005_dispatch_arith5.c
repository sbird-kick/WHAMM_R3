#include <stdio.h>

typedef int (*binop_t)(int, int);

static int add_5(int a, int b) { return a + b; }
static int sub_5(int a, int b) { return a - b; }
static int mul_5(int a, int b) { return (a % 37) * (b % 5); }
static int xorf_5(int a, int b) { return a ^ b; }
static int andf_5(int a, int b) { return a & b; }
static int orf_5(int a, int b) { return a | b; }
static int shl_5(int a, int b) { return (a & 0xF) << (b % 4); }
static int avg_5(int a, int b) { return (a + b) / 2; }

static binop_t table_5[8] = { add_5, sub_5, mul_5, xorf_5, andf_5, orf_5, shl_5, avg_5 };

int main(void) {
    int a = 175, b = 8;
    long acc = 0;
    for (int i = 0; i < 21; i++) {
        int idx = (a + i) % 8;
        acc += table_5[idx](a, b);
        a = (a * 3 + i) % 10007;
        b = (b + 5) % 251;
    }
    printf("A5 acc=%ld a=%d b=%d\n", acc, a, b);
    return 0;
}
