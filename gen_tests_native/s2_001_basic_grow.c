#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
    size_t sizes[] = {222, 444, 888, 1776, 3552, 7104, 14208, 28416};
    unsigned long checksum = 0;
    for (int i = 0; i < 8; i++) {
        char *p = (char *)malloc(sizes[i]);
        if (!p) continue;
        memset(p, (int)(i + 1), sizes[i]);
        for (size_t j = 0; j < sizes[i]; j += 37) {
            checksum += (unsigned char)p[j];
        }
        free(p);
    }
    printf("checksum=%lu\n", checksum);
    return 0;
}
