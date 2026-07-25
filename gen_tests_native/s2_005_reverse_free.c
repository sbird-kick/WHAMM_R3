#include <stdio.h>
#include <stdlib.h>
int main(void) {
    #define N 111
    char *arr[N];
    for (int i = 0; i < N; i++) {
        size_t s = (size_t)(i % 17) * 13 + 4;
        arr[i] = (char *)malloc(s);
        for (size_t j = 0; j < s; j++) arr[i][j] = (char)(i + j);
    }
    long chk = 0;
    for (int i = N - 1; i >= 0; i--) {
        chk += (unsigned char)arr[i][0];
        free(arr[i]);
    }
    printf("chk=%ld\n", chk);
    return 0;
}
