#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    unsigned long chk = 0;
    for (int i = 1; i <= 20; i++) {
        for (int j = 1; j <= 10; j++) {
            size_t sz = (size_t)(i * j) + 10;
            char *p = (char *)malloc(sz);
            memset(p, (i + j) & 0xFF, sz);
            chk += (unsigned char)p[sz / 2];
            free(p);
        }
    }
    printf("chk=%lu\n", chk);
    return 0;
}
