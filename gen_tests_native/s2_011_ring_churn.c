#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    #define RN 16
    char *ring[RN] = {0};
    unsigned long chk = 0;
    for (int i = 0; i < 222; i++) {
        int slot = i % RN;
        if (ring[slot]) free(ring[slot]);
        size_t s = (size_t)((i * 7) % 500) + 8;
        ring[slot] = (char *)malloc(s);
        memset(ring[slot], i & 0xFF, s);
        chk += (unsigned char)ring[slot][0];
    }
    for (int i = 0; i < RN; i++) if (ring[i]) free(ring[i]);
    printf("chk=%lu\n", chk);
    return 0;
}
