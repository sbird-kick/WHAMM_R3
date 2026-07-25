#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    size_t n = 1000;
    long *arr = (long *)calloc(n, sizeof(long));
    for (size_t i = 0; i < n; i += 222) arr[i] = (long)i * 3;
    n *= 2;
    arr = (long *)realloc(arr, n * sizeof(long));
    memset(arr + n / 2, 0, (n / 2) * sizeof(long));
    for (size_t i = n / 2; i < n; i += 333) arr[i] = (long)i;
    n *= 2;
    arr = (long *)realloc(arr, n * sizeof(long));
    memset(arr + n / 2, 0, (n / 2) * sizeof(long));
    long sum = 0;
    for (size_t i = 0; i < n; i += 111) sum += arr[i];
    printf("sum=%ld n=%zu\n", sum, n);
    free(arr);
    return 0;
}
