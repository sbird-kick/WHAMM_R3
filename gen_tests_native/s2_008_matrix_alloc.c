#include <stdio.h>
#include <stdlib.h>
int main(void) {
    int rows = 22, cols = 22;
    int **m = (int **)malloc(sizeof(int *) * rows);
    for (int i = 0; i < rows; i++) {
        m[i] = (int *)malloc(sizeof(int) * cols);
        for (int j = 0; j < cols; j++) m[i][j] = i * cols + j;
    }
    long sum = 0;
    for (int i = 0; i < rows; i++)
        for (int j = 0; j < cols; j++) sum += m[i][j];
    for (int i = 0; i < rows; i++) free(m[i]);
    free(m);
    printf("matsum=%ld\n", sum);
    return 0;
}
