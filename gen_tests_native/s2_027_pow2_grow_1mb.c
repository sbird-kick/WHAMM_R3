#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    unsigned long chk = 0;
    for (int e = 6; e <= 20; e++) {
        size_t sz = (size_t)1 << e;
        char *p = (char *)malloc(sz);
        if (!p) break;
        p[0] = (char)e; p[sz - 1] = (char)(e + 1);
        chk += (unsigned char)p[0] + (unsigned char)p[sz - 1];
        free(p);
    }
    printf("chk=%lu\n", chk);
    return 0;
}
