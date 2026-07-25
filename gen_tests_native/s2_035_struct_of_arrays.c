#include <stdio.h>
#include <stdlib.h>
int main(void) {
    int n = 222;
    int *xs = (int *)malloc(sizeof(int) * n);
    int *ys = (int *)malloc(sizeof(int) * n);
    float *ws = (float *)malloc(sizeof(float) * n);
    for (int i = 0; i < n; i++) { xs[i] = i; ys[i] = i * 2; ws[i] = (float)i * 0.5f; }
    long sum = 0;
    for (int i = 0; i < n; i++) sum += xs[i] + ys[i] + (int)ws[i];
    free(xs); free(ys); free(ws);
    printf("sum=%ld\n", sum);
    return 0;
}
