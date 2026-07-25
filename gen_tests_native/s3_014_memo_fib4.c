#include <stdio.h>

static long memo_4[64];
static char have_4[64];

static long fib_4(int n) {
    if (n <= 1) return n;
    if (have_4[n]) return memo_4[n];
    long r = (fib_4(n - 1) + fib_4(n - 2)) % 101332;
    memo_4[n] = r;
    have_4[n] = 1;
    return r;
}

int main(void) {
    long sum = 0;
    for (int i = 0; i <= 19; i++) {
        sum += fib_4(i);
    }
    printf("C4 sum=%ld fib=%ld\n", sum, fib_4(19));
    return 0;
}
