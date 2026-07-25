#include <stdio.h>

static long memo_5[20][20];
static char have_5[20][20];

static long binom_5(int n, int k) {
    if (k == 0 || k == n) return 1;
    if (k < 0 || k > n) return 0;
    if (have_5[n][k]) return memo_5[n][k];
    long r = binom_5(n - 1, k - 1) + binom_5(n - 1, k);
    memo_5[n][k] = r;
    have_5[n][k] = 1;
    return r;
}

int main(void) {
    long sum = 0;
    for (int i = 0; i <= 12; i++) {
        for (int j = 0; j <= i; j++) {
            sum += binom_5(i, j);
        }
    }
    printf("J5 sum=%ld binom=%ld\n", sum, binom_5(12, 12 / 2));
    return 0;
}
