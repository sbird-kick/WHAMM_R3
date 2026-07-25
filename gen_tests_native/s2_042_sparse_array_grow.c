#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    size_t cap = 100;
    int *sparse = (int *)calloc(cap, sizeof(int));
    int idxs[] = {5, 222, 999, 50, 800, 300, 2, 1500};
    for (int k = 0; k < 8; k++) {
        int idx = idxs[k];
        if ((size_t)idx >= cap) {
            size_t ncap = (size_t)idx + 1;
            int *n = (int *)realloc(sparse, ncap * sizeof(int));
            memset(n + cap, 0, (ncap - cap) * sizeof(int));
            sparse = n; cap = ncap;
        }
        sparse[idx] = k + 1;
    }
    long sum = 0;
    for (size_t i = 0; i < cap; i++) sum += sparse[i];
    printf("sum=%ld cap=%zu\n", sum, cap);
    free(sparse);
    return 0;
}
