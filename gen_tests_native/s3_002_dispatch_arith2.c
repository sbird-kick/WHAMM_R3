#include <stdio.h>

typedef int (*binop_t)(int, int);

static int add_2(int a, int b) { return a + b; }
static int sub_2(int a, int b) { return a - b; }
static int mul_2(int a, int b) { return (a % 37) * (b % 5); }
static int xorf_2(int a, int b) { return a ^ b; }
static int andf_2(int a, int b) { return a & b; }
static int orf_2(int a, int b) { return a | b; }
static int shl_2(int a, int b) { return (a & 0xF) << (b % 4); }
static int avg_2(int a, int b) { return (a + b) / 2; }

static binop_t table_2[8] = { add_2, sub_2, mul_2, xorf_2, andf_2, orf_2, shl_2, avg_2 };

int main(void) {
    int a = 176, b = 9;
    long acc = 0;
    for (int i = 0; i < 30; i++) {
        int idx = (a + i) % 8;
        acc += table_2[idx](a, b);
        a = (a * 3 + i) % 10007;
        b = (b + 5) % 251;
    }
    printf("A2 acc=%ld a=%d b=%d\n", acc, a, b);
    return 0;
}
