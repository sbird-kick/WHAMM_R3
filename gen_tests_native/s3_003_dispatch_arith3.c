#include <stdio.h>

typedef int (*binop_t)(int, int);

static int add_3(int a, int b) { return a + b; }
static int sub_3(int a, int b) { return a - b; }
static int mul_3(int a, int b) { return (a % 37) * (b % 5); }
static int xorf_3(int a, int b) { return a ^ b; }
static int andf_3(int a, int b) { return a & b; }
static int orf_3(int a, int b) { return a | b; }
static int shl_3(int a, int b) { return (a & 0xF) << (b % 4); }
static int avg_3(int a, int b) { return (a + b) / 2; }

static binop_t table_3[8] = { add_3, sub_3, mul_3, xorf_3, andf_3, orf_3, shl_3, avg_3 };

int main(void) {
    int a = 509, b = 19;
    long acc = 0;
    for (int i = 0; i < 22; i++) {
        int idx = (a + i) % 8;
        acc += table_3[idx](a, b);
        a = (a * 3 + i) % 10007;
        b = (b + 5) % 251;
    }
    printf("A3 acc=%ld a=%d b=%d\n", acc, a, b);
    return 0;
}
