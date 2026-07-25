#include <stdio.h>

static int is_even_4(int n);
static int is_odd_4(int n) {
    if (n == 0) return 0;
    return is_even_4(n - 1);
}
static int is_even_4(int n) {
    if (n == 0) return 1;
    return is_odd_4(n - 1);
}

int main(void) {
    int evens = 0, odds = 0;
    for (int i = 0; i < 27; i++) {
        if (is_even_4(i)) evens++;
        else odds++;
    }
    printf("G4 evens=%d odds=%d\n", evens, odds);
    return 0;
}
