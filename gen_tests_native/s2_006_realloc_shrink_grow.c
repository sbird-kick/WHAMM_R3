#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    size_t sz = 4096;
    char *p = (char *)malloc(sz);
    memset(p, 7, sz);
    p = (char *)realloc(p, 512);
    sz = 512;
    unsigned long a = 0;
    for (size_t i = 0; i < sz; i++) a += (unsigned char)p[i];
    sz = 8192;
    p = (char *)realloc(p, sz);
    memset(p + 512, 9, sz - 512);
    unsigned long b = 0;
    for (size_t i = 0; i < sz; i += 31) b += (unsigned char)p[i];
    printf("a=%lu b=%lu\n", a, b);
    free(p);
    return 0;
}
