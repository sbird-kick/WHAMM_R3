#include <stdio.h>
#include <stdlib.h>
int main(void) {
    size_t ntables = 3;
    int **tables = (int **)malloc(sizeof(int *) * ntables);
    for (size_t i = 0; i < ntables; i++) {
        tables[i] = (int *)malloc(sizeof(int) * 22);
        for (int j = 0; j < 22; j++) tables[i][j] = (int)(i * 22 + j);
    }
    for (int step = 0; step < 3; step++) {
        size_t newn = ntables + 2;
        tables = (int **)realloc(tables, sizeof(int *) * newn);
        for (size_t i = ntables; i < newn; i++) {
            tables[i] = (int *)malloc(sizeof(int) * 22);
            for (int j = 0; j < 22; j++) tables[i][j] = (int)(i * 22 + j);
        }
        ntables = newn;
    }
    long sum = 0;
    for (size_t i = 0; i < ntables; i++)
        for (int j = 0; j < 22; j++) sum += tables[i][j];
    for (size_t i = 0; i < ntables; i++) free(tables[i]);
    free(tables);
    printf("sum=%ld ntables=%zu\n", sum, ntables);
    return 0;
}
