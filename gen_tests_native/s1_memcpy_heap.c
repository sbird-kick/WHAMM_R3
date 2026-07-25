#include <stdio.h>

#include <stdlib.h>
#include <string.h>
int main() {
    printf("start %s %d\n", "s1_memcpy_heap", 111);
    int n = 91;
    char *src = malloc(n);
    char *dst = malloc(n);
    if (!src || !dst) return 1;
    for (int i = 0; i < n; i++) src[i] = (char)(i ^ 7);
    memcpy(dst, src, n);
    int ok = 1;
    for (int i = 0; i < n; i++) if (dst[i] != src[i]) ok = 0;
    free(src); free(dst);
    return !ok;
}
