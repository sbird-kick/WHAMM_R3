#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    #define FN 80
    char *arr[FN];
    for (int i = 0; i < FN; i++) {
        size_t s = (size_t)(i * 3 + 10);
        arr[i] = (char *)malloc(s);
        memset(arr[i], i, s);
    }
    for (int i = 0; i < FN; i += 2) { free(arr[i]); arr[i] = NULL; }
    for (int i = 0; i < FN; i += 2) {
        size_t s = (size_t)(i * 5 + 20);
        arr[i] = (char *)malloc(s);
        memset(arr[i], i + 1, s);
    }
    unsigned long chk = 0;
    for (int i = 0; i < FN; i++) { chk += (unsigned char)arr[i][0]; free(arr[i]); }
    printf("chk=%lu\n", chk);
    return 0;
}
