#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    size_t a = 22, b = 35;
    unsigned long total = 0;
    for (int i = 0; i < 14; i++) {
        char *p = (char *)malloc(a);
        memset(p, i + 1, a);
        total += (unsigned char)p[a - 1];
        free(p);
        size_t t = a + b; a = b; b = t;
        if (b > 30000) b = 30000;
    }
    printf("total=%lu\n", total);
    return 0;
}
