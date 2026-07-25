#include <stdio.h>

static long memo_4[20][20];
static char have_4[20][20];

static long binom_4(int n, int k) {
    if (k == 0 || k == n) return 1;
    if (k < 0 || k > n) return 0;
    if (have_4[n][k]) return memo_4[n][k];
    long r = binom_4(n - 1, k - 1) + binom_4(n - 1, k);
    memo_4[n][k] = r;
    have_4[n][k] = 1;
    return r;
}

int main(void) {
    long sum = 0;
    for (int i = 0; i <= 11; i++) {
        for (int j = 0; j <= i; j++) {
            sum += binom_4(i, j);
        }
    }
    printf("J4 sum=%ld binom=%ld\n", sum, binom_4(11, 11 / 2));
    return 0;
}
