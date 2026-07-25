#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    size_t sz = 2048;
    char *p = (char *)malloc(sz);
    for (size_t i = 0; i < sz; i++) p[i] = (char)(i & 0xFF);
    memmove(p + 100, p, sz - 100);
    p = (char *)realloc(p, sz * 2);
    memmove(p + sz, p, sz);
    unsigned long chk = 0;
    for (size_t i = 0; i < sz * 2; i += 53) chk += (unsigned char)p[i];
    printf("chk=%lu\n", chk);
    free(p);
    return 0;
}
