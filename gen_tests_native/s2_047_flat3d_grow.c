#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    int d1 = 4, d2 = 4, d3 = 4;
    size_t total = (size_t)d1 * d2 * d3;
    int *arr = (int *)malloc(sizeof(int) * total);
    for (size_t i = 0; i < total; i++) arr[i] = (int)i;
    for (int grow = 0; grow < 2; grow++) {
        d3 *= 2;
        size_t ntotal = (size_t)d1 * d2 * d3;
        int *narr = (int *)malloc(sizeof(int) * ntotal);
        memcpy(narr, arr, sizeof(int) * total);
        for (size_t i = total; i < ntotal; i++) narr[i] = (int)i;
        free(arr);
        arr = narr; total = ntotal;
    }
    long sum = 0;
    for (size_t i = 0; i < total; i++) sum += arr[i];
    printf("sum=%ld total=%zu\n", sum, total);
    free(arr);
    return 0;
}
