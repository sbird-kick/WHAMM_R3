#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    size_t sz = 64;
    unsigned long total = 0;
    for (int i = 0; i < 12; i++) {
        char *p = (char *)malloc(sz);
        if (!p) break;
        memset(p, i, sz);
        total += (unsigned char)p[sz - 1];
        free(p);
        sz *= 2;
    }
    printf("total=%lu final=%zu\n", total, sz);
    return 0;
}
