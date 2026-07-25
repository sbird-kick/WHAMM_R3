#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    char *p = NULL;
    size_t sz = 0;
    for (int i = 0; i < 10; i++) {
        sz += 222;
        p = (char *)realloc(p, sz);
        memset(p + sz - 222, i, 222);
    }
    unsigned long chk = 0;
    for (size_t j = 0; j < sz; j += 111) chk += (unsigned char)p[j];
    printf("chk=%lu sz=%zu\n", chk, sz);
    free(p);
    return 0;
}
