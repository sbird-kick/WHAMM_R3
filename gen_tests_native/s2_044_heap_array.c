#include <stdio.h>
#include <stdlib.h>
int main(void) {
    size_t cap = 8, n = 0;
    int *heap = (int *)malloc(sizeof(int) * cap);
    int vals[] = {50,222,17,900,3,450,88,600,12,777,300,5,999,1,42};
    for (int k = 0; k < 15; k++) {
        if (n == cap) { cap *= 2; heap = (int *)realloc(heap, sizeof(int) * cap); }
        size_t i = n++;
        heap[i] = vals[k];
        while (i > 0) {
            size_t p = (i - 1) / 2;
            if (heap[p] <= heap[i]) break;
            int t = heap[p]; heap[p] = heap[i]; heap[i] = t;
            i = p;
        }
    }
    long sum = 0;
    for (size_t i = 0; i < n; i++) sum += heap[i];
    printf("sum=%ld top=%d\n", sum, heap[0]);
    free(heap);
    return 0;
}
