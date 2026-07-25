#include <stdio.h>
#include <stdlib.h>
typedef struct { char c; long v; short s; } Padded;
int main(void) {
    size_t n = 10;
    Padded *arr = (Padded *)calloc(n, sizeof(Padded));
    unsigned long zerobytes = 0;
    for (size_t i = 0; i < n; i++) {
        if (arr[i].c == 0 && arr[i].v == 0 && arr[i].s == 0) zerobytes++;
        arr[i].v = (long)(i * 222);
    }
    n *= 4;
    arr = (Padded *)realloc(arr, n * sizeof(Padded));
    long sum = 0;
    for (size_t i = 0; i < n; i++) sum += arr[i].v;
    printf("zerobytes=%lu sum=%ld\n", zerobytes, sum);
    free(arr);
    return 0;
}
