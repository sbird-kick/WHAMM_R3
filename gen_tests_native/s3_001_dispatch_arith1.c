#include <stdio.h>

typedef int (*binop_t)(int, int);

static int add_1(int a, int b) { return a + b; }
static int sub_1(int a, int b) { return a - b; }
static int mul_1(int a, int b) { return (a % 37) * (b % 5); }
static int xorf_1(int a, int b) { return a ^ b; }
static int andf_1(int a, int b) { return a & b; }
static int orf_1(int a, int b) { return a | b; }
static int shl_1(int a, int b) { return (a & 0xF) << (b % 4); }
static int avg_1(int a, int b) { return (a + b) / 2; }

static binop_t table_1[8] = { add_1, sub_1, mul_1, xorf_1, andf_1, orf_1, shl_1, avg_1 };

int main(void) {
    int a = 343, b = 6;
    long acc = 0;
    for (int i = 0; i < 23; i++) {
        int idx = (a + i) % 8;
        acc += table_1[idx](a, b);
        a = (a * 3 + i) % 10007;
        b = (b + 5) % 251;
    }
    printf("A1 acc=%ld a=%d b=%d\n", acc, a, b);
    return 0;
}
