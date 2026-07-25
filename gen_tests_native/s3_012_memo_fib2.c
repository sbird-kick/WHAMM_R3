#include <stdio.h>

static long memo_2[64];
static char have_2[64];

static long fib_2(int n) {
    if (n <= 1) return n;
    if (have_2[n]) return memo_2[n];
    long r = (fib_2(n - 1) + fib_2(n - 2)) % 100666;
    memo_2[n] = r;
    have_2[n] = 1;
    return r;
}

int main(void) {
    long sum = 0;
    for (int i = 0; i <= 13; i++) {
        sum += fib_2(i);
    }
    printf("C2 sum=%ld fib=%ld\n", sum, fib_2(13));
    return 0;
}
