#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    unsigned long chk = 0;
    size_t small = 32, big = 8192;
    for (int i = 0; i < 100; i++) {
        char *a = (char *)malloc(small);
        char *b = (char *)malloc(big);
        memset(a, i, small);
        memset(b, i + 1, big);
        chk += (unsigned char)a[small - 1] + (unsigned char)b[big - 1];
        free(a);
        free(b);
        small += 1; big -= 4;
        if (big < 1024) big = 8192;
    }
    printf("chk=%lu\n", chk);
    return 0;
}
