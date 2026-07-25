#include <stdio.h>
#include <stdlib.h>
typedef struct { int a, b, c, d; } Quad;
int main(void) {
    unsigned long zeros = 0;
    int counts[] = {5, 25, 125, 625};
    for (int k = 0; k < 4; k++) {
        Quad *arr = (Quad *)calloc(counts[k], sizeof(Quad));
        for (int i = 0; i < counts[k]; i++) {
            if (arr[i].a == 0 && arr[i].b == 0) zeros++;
            arr[i].a = i; arr[i].c = i * 2;
        }
        free(arr);
    }
    printf("zeros=%lu\n", zeros);
    return 0;
}
