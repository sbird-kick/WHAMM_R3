// memory.copy (memmove) and memory.fill (memset) — bulk memory operations
#include <stdlib.h>
#include <string.h>

int main() {
    char *a = malloc(1024);
    char *b = malloc(1024);

    // Fill a with pattern
    memset(a, 0x42, 1024);

    // Copy a -> b
    memcpy(b, a, 1024);

    // Overlapping memmove within a
    memmove(a + 100, a + 50, 500);

    // Verify b is all 0x42
    int ok = 1;
    for (int i = 0; i < 1024; i++) {
        if ((unsigned char)b[i] != 0x42) { ok = 0; break; }
    }

    // memset to zero
    memset(b, 0, 1024);
    for (int i = 0; i < 1024; i++) {
        if (b[i] != 0) { ok = 0; break; }
    }

    free(a);
    free(b);
    return !ok;
}
