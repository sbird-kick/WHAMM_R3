#include <stdio.h>
#include <stdlib.h>
int main(void) {
    int n = 50;
    int **arr = (int **)malloc(sizeof(int *) * n);
    for (int i = 0; i < n; i++) {
        arr[i] = (int *)malloc(sizeof(int));
        *arr[i] = (i * 71 + 222) % 997;
    }
    for (int i = 0; i < n - 1; i++)
        for (int j = 0; j < n - 1 - i; j++)
            if (*arr[j] > *arr[j + 1]) { int *t = arr[j]; arr[j] = arr[j + 1]; arr[j + 1] = t; }
    long sum = 0;
    for (int i = 0; i < n; i++) { sum += *arr[i] * (i + 1); free(arr[i]); }
    free(arr);
    printf("sum=%ld\n", sum);
    return 0;
}
