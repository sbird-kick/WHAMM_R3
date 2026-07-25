#include <stdio.h>

static long memo_3[64];
static char have_3[64];

static long fib_3(int n) {
    if (n <= 1) return n;
    if (have_3[n]) return memo_3[n];
    long r = (fib_3(n - 1) + fib_3(n - 2)) % 100999;
    memo_3[n] = r;
    have_3[n] = 1;
    return r;
}

int main(void) {
    long sum = 0;
    for (int i = 0; i <= 16; i++) {
        sum += fib_3(i);
    }
    printf("C3 sum=%ld fib=%ld\n", sum, fib_3(16));
    return 0;
}
