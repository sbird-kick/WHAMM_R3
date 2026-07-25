#include <stdio.h>

static long memo_1[20][20];
static char have_1[20][20];

static long binom_1(int n, int k) {
    if (k == 0 || k == n) return 1;
    if (k < 0 || k > n) return 0;
    if (have_1[n][k]) return memo_1[n][k];
    long r = binom_1(n - 1, k - 1) + binom_1(n - 1, k);
    memo_1[n][k] = r;
    have_1[n][k] = 1;
    return r;
}

int main(void) {
    long sum = 0;
    for (int i = 0; i <= 8; i++) {
        for (int j = 0; j <= i; j++) {
            sum += binom_1(i, j);
        }
    }
    printf("J1 sum=%ld binom=%ld\n", sum, binom_1(8, 8 / 2));
    return 0;
}
