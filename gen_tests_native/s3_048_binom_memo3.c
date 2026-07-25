#include <stdio.h>

static long memo_3[20][20];
static char have_3[20][20];

static long binom_3(int n, int k) {
    if (k == 0 || k == n) return 1;
    if (k < 0 || k > n) return 0;
    if (have_3[n][k]) return memo_3[n][k];
    long r = binom_3(n - 1, k - 1) + binom_3(n - 1, k);
    memo_3[n][k] = r;
    have_3[n][k] = 1;
    return r;
}

int main(void) {
    long sum = 0;
    for (int i = 0; i <= 10; i++) {
        for (int j = 0; j <= i; j++) {
            sum += binom_3(i, j);
        }
    }
    printf("J3 sum=%ld binom=%ld\n", sum, binom_3(10, 10 / 2));
    return 0;
}
