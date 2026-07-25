#include <stdio.h>

static long memo_1[64];
static char have_1[64];

static long fib_1(int n) {
    if (n <= 1) return n;
    if (have_1[n]) return memo_1[n];
    long r = (fib_1(n - 1) + fib_1(n - 2)) % 100333;
    memo_1[n] = r;
    have_1[n] = 1;
    return r;
}

int main(void) {
    long sum = 0;
    for (int i = 0; i <= 10; i++) {
        sum += fib_1(i);
    }
    printf("C1 sum=%ld fib=%ld\n", sum, fib_1(10));
    return 0;
}
