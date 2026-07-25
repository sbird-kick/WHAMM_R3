#include <stdio.h>

static void swap_4(int *a, int *b) { int t = *a; *a = *b; *b = t; }

static void qsort_4(int *arr, int lo, int hi) {
    if (lo >= hi) return;
    int pivot = arr[(lo + hi) / 2];
    int i = lo, j = hi;
    while (i <= j) {
        while (arr[i] < pivot) i++;
        while (arr[j] > pivot) j--;
        if (i <= j) {
            swap_4(&arr[i], &arr[j]);
            i++; j--;
        }
    }
    if (lo < j) qsort_4(arr, lo, j);
    if (i < hi) qsort_4(arr, i, hi);
}

int main(void) {
    int arr[22];
    unsigned s = 3331;
    for (int i = 0; i < 22; i++) {
        s = (s * 1103515245u + 12345u) & 0x7fffffffu;
        arr[i] = (int)(s % 500);
    }
    qsort_4(arr, 0, 22 - 1);
    long checksum = 0;
    for (int i = 0; i < 22; i++) checksum += (long)arr[i] * (i + 1);
    printf("I4 checksum=%ld first=%d last=%d\n", checksum, arr[0], arr[22 - 1]);
    return 0;
}
