#include <stdio.h>
#include <stdlib.h>
int main(void) {
    unsigned long nonzero = 0;
    size_t counts[] = {8, 40, 200, 1000, 5000, 22000};
    for (int i = 0; i < 6; i++) {
        unsigned char *p = (unsigned char *)calloc(counts[i], 1);
        if (!p) continue;
        for (size_t j = 0; j < counts[i]; j++) nonzero += p[j];
        free(p);
    }
    printf("nonzero=%lu\n", nonzero);
    return 0;
}
