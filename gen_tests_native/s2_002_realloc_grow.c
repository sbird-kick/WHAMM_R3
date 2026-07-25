#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
    size_t sz = 111;
    char *p = (char *)malloc(sz);
    for (int i = 0; i < 9; i++) {
        memset(p, i + 1, sz);
        sz = sz * 2 + 22;
        p = (char *)realloc(p, sz);
        if (!p) return 1;
    }
    unsigned long sum = 0;
    for (size_t j = 0; j < sz; j += 53) sum += (unsigned char)p[j];
    printf("sum=%lu final_sz=%zu\n", sum, sz);
    free(p);
    return 0;
}
