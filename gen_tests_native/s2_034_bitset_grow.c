#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    size_t nbytes = 4;
    unsigned char *bits = (unsigned char *)calloc(nbytes, 1);
    for (int i = 0; i < 500; i++) {
        size_t byte = (size_t)i / 8;
        if (byte >= nbytes) {
            size_t newn = nbytes * 2;
            bits = (unsigned char *)realloc(bits, newn);
            memset(bits + nbytes, 0, newn - nbytes);
            nbytes = newn;
        }
        bits[byte] |= (unsigned char)(1 << (i % 8));
    }
    unsigned long pop = 0;
    for (size_t i = 0; i < nbytes; i++) {
        unsigned char b = bits[i];
        while (b) { pop += b & 1; b >>= 1; }
    }
    printf("pop=%lu nbytes=%zu\n", pop, nbytes);
    free(bits);
    return 0;
}
