#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    size_t n = 2000;
    int *src = (int *)malloc(sizeof(int) * n);
    for (size_t i = 0; i < n; i++) src[i] = (int)(i * 3 % 997);
    size_t scratch_sz = 64;
    int *scratch = (int *)malloc(sizeof(int) * scratch_sz);
    long sum = 0;
    for (size_t off = 0; off + scratch_sz <= n; off += scratch_sz) {
        memcpy(scratch, src + off, sizeof(int) * scratch_sz);
        for (size_t i = 0; i < scratch_sz; i++) sum += scratch[i];
        scratch_sz += 16;
        scratch = (int *)realloc(scratch, sizeof(int) * scratch_sz);
    }
    printf("sum=%ld\n", sum);
    free(src); free(scratch);
    return 0;
}
