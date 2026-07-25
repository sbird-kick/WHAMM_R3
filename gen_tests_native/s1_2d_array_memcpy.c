#include <stdio.h>

#include <string.h>
int main() {
    printf("start %s %d\n", "s1_2d_array_memcpy", 111);
    int rows = 10;
    int cols = 3;
    int a[10][8];
    int b[10][8];
    for (int i = 0; i < rows; i++)
        for (int j = 0; j < cols; j++)
            a[i][j] = i * cols + j;
    for (int i = 0; i < rows; i++)
        memcpy(b[i], a[i], cols * sizeof(int));
    int ok = 1;
    for (int i = 0; i < rows; i++)
        for (int j = 0; j < cols; j++)
            if (b[i][j] != a[i][j]) ok = 0;
    return !ok;
}
