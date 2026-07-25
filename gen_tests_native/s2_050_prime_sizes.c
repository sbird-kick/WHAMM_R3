#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    int primes[] = {2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71};
    unsigned long chk = 0;
    for (int i = 0; i < 20; i++) {
        size_t sz = (size_t)primes[i] * 222;
        char *p = (char *)malloc(sz);
        memset(p, primes[i], sz);
        chk += (unsigned char)p[sz - 1];
        free(p);
    }
    printf("chk=%lu\n", chk);
    return 0;
}
