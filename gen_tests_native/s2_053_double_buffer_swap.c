#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    size_t sz = 512;
    int *a = (int *)malloc(sizeof(int) * sz);
    int *b = (int *)malloc(sizeof(int) * sz);
    for (size_t i = 0; i < sz; i++) a[i] = (int)i;
    for (int step = 0; step < 5; step++) {
        for (size_t i = 0; i < sz; i++) b[i] = a[i] * 2 + 1;
        int *t = a; a = b; b = t;
    }
    long sum = 0;
    for (size_t i = 0; i < sz; i++) sum += a[i];
    printf("sum=%ld\n", sum);
    free(a); free(b);
    return 0;
}
