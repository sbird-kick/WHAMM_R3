#include <stdio.h>

static long memo_2[20][20];
static char have_2[20][20];

static long binom_2(int n, int k) {
    if (k == 0 || k == n) return 1;
    if (k < 0 || k > n) return 0;
    if (have_2[n][k]) return memo_2[n][k];
    long r = binom_2(n - 1, k - 1) + binom_2(n - 1, k);
    memo_2[n][k] = r;
    have_2[n][k] = 1;
    return r;
}

int main(void) {
    long sum = 0;
    for (int i = 0; i <= 9; i++) {
        for (int j = 0; j <= i; j++) {
            sum += binom_2(i, j);
        }
    }
    printf("J2 sum=%ld binom=%ld\n", sum, binom_2(9, 9 / 2));
    return 0;
}
