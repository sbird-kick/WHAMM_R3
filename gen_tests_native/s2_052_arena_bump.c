#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    size_t arena_sz = 1024;
    char *arena = (char *)malloc(arena_sz);
    size_t off = 0;
    unsigned long chk = 0;
    for (int i = 0; i < 100; i++) {
        size_t need = (size_t)(i % 40) + 8;
        if (off + need > arena_sz) {
            size_t nsz = arena_sz * 2;
            arena = (char *)realloc(arena, nsz);
            arena_sz = nsz;
        }
        memset(arena + off, i & 0xFF, need);
        chk += (unsigned char)arena[off];
        off += need;
    }
    printf("chk=%lu off=%zu arena_sz=%zu\n", chk, off, arena_sz);
    free(arena);
    return 0;
}
