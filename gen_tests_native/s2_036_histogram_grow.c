#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    size_t cap = 16;
    unsigned int *hist = (unsigned int *)calloc(cap, sizeof(unsigned int));
    for (int i = 0; i < 1000; i++) {
        unsigned int bucket = (unsigned)((i * 37 + 11) % 300);
        if (bucket >= cap) {
            size_t ncap = cap;
            while (ncap <= bucket) ncap *= 2;
            hist = (unsigned int *)realloc(hist, ncap * sizeof(unsigned int));
            memset(hist + cap, 0, (ncap - cap) * sizeof(unsigned int));
            cap = ncap;
        }
        hist[bucket]++;
    }
    unsigned long total = 0;
    for (size_t i = 0; i < cap; i++) total += hist[i];
    printf("total=%lu cap=%zu\n", total, cap);
    free(hist);
    return 0;
}
