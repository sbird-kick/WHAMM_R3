#include <stdio.h>

static long memo_5[64];
static char have_5[64];

static long fib_5(int n) {
    if (n <= 1) return n;
    if (have_5[n]) return memo_5[n];
    long r = (fib_5(n - 1) + fib_5(n - 2)) % 101665;
    memo_5[n] = r;
    have_5[n] = 1;
    return r;
}

int main(void) {
    long sum = 0;
    for (int i = 0; i <= 22; i++) {
        sum += fib_5(i);
    }
    printf("C5 sum=%ld fib=%ld\n", sum, fib_5(22));
    return 0;
}
