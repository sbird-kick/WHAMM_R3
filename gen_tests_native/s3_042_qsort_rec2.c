#include <stdio.h>

static void swap_2(int *a, int *b) { int t = *a; *a = *b; *b = t; }

static void qsort_2(int *arr, int lo, int hi) {
    if (lo >= hi) return;
    int pivot = arr[(lo + hi) / 2];
    int i = lo, j = hi;
    while (i <= j) {
        while (arr[i] < pivot) i++;
        while (arr[j] > pivot) j--;
        if (i <= j) {
            swap_2(&arr[i], &arr[j]);
            i++; j--;
        }
    }
    if (lo < j) qsort_2(arr, lo, j);
    if (i < hi) qsort_2(arr, i, hi);
}

int main(void) {
    int arr[14];
    unsigned s = 2665;
    for (int i = 0; i < 14; i++) {
        s = (s * 1103515245u + 12345u) & 0x7fffffffu;
        arr[i] = (int)(s % 500);
    }
    qsort_2(arr, 0, 14 - 1);
    long checksum = 0;
    for (int i = 0; i < 14; i++) checksum += (long)arr[i] * (i + 1);
    printf("I2 checksum=%ld first=%d last=%d\n", checksum, arr[0], arr[14 - 1]);
    return 0;
}
