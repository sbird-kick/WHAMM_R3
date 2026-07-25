#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    unsigned long chk = 0;
    for (int i = 0; i < 60; i++) {
        size_t sz = (size_t)(i + 1) * 222;
        char *p;
        if (i % 3 == 0) p = (char *)malloc(sz);
        else if (i % 3 == 1) p = (char *)calloc(sz, 1);
        else { p = (char *)malloc(sz / 2); p = (char *)realloc(p, sz); }
        p[0] = (char)i;
        p[sz - 1] = (char)(i + 1);
        chk += (unsigned char)p[0] + (unsigned char)p[sz - 1];
        free(p);
    }
    printf("chk=%lu\n", chk);
    return 0;
}
