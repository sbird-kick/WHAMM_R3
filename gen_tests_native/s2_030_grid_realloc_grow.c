#include <stdio.h>
#include <stdlib.h>
int main(void) {
    int rows = 4, cols = 22;
    int **grid = (int **)malloc(sizeof(int *) * rows);
    for (int i = 0; i < rows; i++) grid[i] = (int *)malloc(sizeof(int) * cols);
    for (int step = 0; step < 3; step++) {
        int newrows = rows * 2;
        grid = (int **)realloc(grid, sizeof(int *) * newrows);
        for (int i = rows; i < newrows; i++) grid[i] = (int *)malloc(sizeof(int) * cols);
        rows = newrows;
    }
    long sum = 0;
    for (int i = 0; i < rows; i++)
        for (int j = 0; j < cols; j++) { grid[i][j] = i + j; sum += grid[i][j]; }
    for (int i = 0; i < rows; i++) free(grid[i]);
    free(grid);
    printf("sum=%ld rows=%d\n", sum, rows);
    return 0;
}
