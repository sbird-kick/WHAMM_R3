#include <stdio.h>

#include <stdlib.h>
#include <string.h>
int main() {
    printf("start %s %d\n", "s1_memset_heap", 111);
    int n = 202;
    unsigned char *buf = malloc(n);
    if (!buf) return 1;
    memset(buf, 111, n);
    int ok = 1;
    for (int i = 0; i < n; i++) if (buf[i] != (111 & 0xFF)) ok = 0;
    free(buf);
    return !ok;
}
