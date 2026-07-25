#include <stdio.h>

#include <stdlib.h>
#include <string.h>
int main() {
    printf("start %s %d\n", "s1_array_of_heap_buffers", 111);
    int n = 3;
    char *bufs[10];
    for (int i = 0; i < n; i++) {
        bufs[i] = malloc(16);
        if (!bufs[i]) return 1;
        memset(bufs[i], i + 11, 16);
    }
    char merged[160];
    for (int i = 0; i < n; i++) memcpy(merged + i*16, bufs[i], 16);
    int ok = 1;
    for (int i = 0; i < n; i++)
        for (int j = 0; j < 16; j++)
            if (merged[i*16+j] != (char)(i + 11)) ok = 0;
    for (int i = 0; i < n; i++) free(bufs[i]);
    return !ok;
}
