#include <stdio.h>

typedef struct { double m[3][3]; } Mat;
int main() {
    printf("start %s %d\n", "s1_matrix_struct", 111);
    Mat a, b;
    for (int i = 0; i < 3; i++)
        for (int j = 0; j < 3; j++)
            a.m[i][j] = i * 3 + j + 1 * 0.1;
    b = a;
    int ok = 1;
    for (int i = 0; i < 3; i++)
        for (int j = 0; j < 3; j++)
            if (b.m[i][j] != a.m[i][j]) ok = 0;
    return !ok;
}
