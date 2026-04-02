// realloc forces memory copies + potential memory.grow
#include <stdlib.h>
#include <string.h>

int main() {
    int *buf = malloc(16 * sizeof(int));
    for (int i = 0; i < 16; i++) buf[i] = i;

    // Grow repeatedly — realloc may copy + grow
    for (int round = 0; round < 8; round++) {
        int new_size = 16 * (1 << (round + 1));
        buf = realloc(buf, new_size * sizeof(int));
        for (int i = 0; i < new_size; i++) buf[i] = i;
    }

    // Final size: 16 * 256 = 4096 ints = 16KB
    int ok = (buf[0] == 0 && buf[4095] == 4095);

    free(buf);
    return !ok;
}
