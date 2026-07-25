#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    size_t cap = 4, len = 0;
    int *arr = (int *)malloc(sizeof(int) * cap);
    for (int i = 0; i < 222; i++) {
        if (len == cap) {
            cap *= 2;
            arr = (int *)realloc(arr, sizeof(int) * cap);
        }
        arr[len++] = i * 2;
    }
    long sum = 0;
    for (size_t i = 0; i < len; i++) sum += arr[i];
    printf("sum=%ld cap=%zu\n", sum, cap);
    free(arr);
    return 0;
}
