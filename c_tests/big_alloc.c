// Forces memory.grow by allocating more than the initial memory (1 page = 64KB)
#include <stdlib.h>
#include <string.h>

int main() {
    // Allocate 256KB — well beyond initial 64KB, forces multiple memory.grow
    char *big = malloc(256 * 1024);
    if (!big) return 1;

    // Write a pattern across the whole range
    memset(big, 0xAB, 256 * 1024);

    // Verify
    int ok = 1;
    for (int i = 0; i < 256 * 1024; i++) {
        if ((unsigned char)big[i] != 0xAB) { ok = 0; break; }
    }

    free(big);
    return !ok;
}
