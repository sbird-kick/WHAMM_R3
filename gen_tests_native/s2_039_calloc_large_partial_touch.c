#include <stdio.h>
#include <stdlib.h>
int main(void) {
    size_t n = 50000;
    unsigned char *p = (unsigned char *)calloc(n, 1);
    unsigned long chk = 0;
    for (size_t i = 0; i < n; i += 222) { p[i] = (unsigned char)(i % 256); chk += p[i]; }
    for (size_t i = 0; i < n; i += 4001) chk += p[i];
    printf("chk=%lu\n", chk);
    free(p);
    return 0;
}
