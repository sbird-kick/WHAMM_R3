#include <stdio.h>

typedef int (*binop_t)(int, int);

static int add_4(int a, int b) { return a + b; }
static int sub_4(int a, int b) { return a - b; }
static int mul_4(int a, int b) { return (a % 37) * (b % 5); }
static int xorf_4(int a, int b) { return a ^ b; }
static int andf_4(int a, int b) { return a & b; }
static int orf_4(int a, int b) { return a | b; }
static int shl_4(int a, int b) { return (a & 0xF) << (b % 4); }
static int avg_4(int a, int b) { return (a + b) / 2; }

static binop_t table_4[8] = { add_4, sub_4, mul_4, xorf_4, andf_4, orf_4, shl_4, avg_4 };

int main(void) {
    int a = 342, b = 5;
    long acc = 0;
    for (int i = 0; i < 29; i++) {
        int idx = (a + i) % 8;
        acc += table_4[idx](a, b);
        a = (a * 3 + i) % 10007;
        b = (b + 5) % 251;
    }
    printf("A4 acc=%ld a=%d b=%d\n", acc, a, b);
    return 0;
}
