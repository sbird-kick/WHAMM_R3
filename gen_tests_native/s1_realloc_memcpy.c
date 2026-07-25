#include <stdio.h>

#include <stdlib.h>
#include <string.h>
int main() {
    printf("start %s %d\n", "s1_realloc_memcpy", 111);
    int n = 145;
    char *buf = malloc(n);
    if (!buf) return 1;
    for (int i = 0; i < n; i++) buf[i] = (char)i;
    buf = realloc(buf, n * 4);
    if (!buf) return 1;
    int ok = 1;
    for (int i = 0; i < n; i++) if (buf[i] != (char)i) ok = 0;
    memset(buf + n, 0xCC, n * 3);
    free(buf);
    return !ok;
}
