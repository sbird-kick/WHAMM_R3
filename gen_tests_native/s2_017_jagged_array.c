#include <stdio.h>
#include <stdlib.h>
int main(void) {
    int n = 22;
    int **jag = (int **)malloc(sizeof(int *) * n);
    long sum = 0;
    for (int i = 0; i < n; i++) {
        int len = i + 1;
        jag[i] = (int *)malloc(sizeof(int) * len);
        for (int j = 0; j < len; j++) { jag[i][j] = i * j + 1; sum += jag[i][j]; }
    }
    for (int i = 0; i < n; i++) free(jag[i]);
    free(jag);
    printf("sum=%ld\n", sum);
    return 0;
}
