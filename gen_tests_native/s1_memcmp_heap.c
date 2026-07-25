#include <stdio.h>

#include <stdlib.h>
#include <string.h>
int main() {
    printf("start %s %d\n", "s1_memcmp_heap", 111);
    int n = 61;
    char *a = malloc(n);
    char *b = malloc(n);
    if (!a||!b) return 1;
    memset(a, 11, n);
    memset(b, 11, n);
    int r = memcmp(a, b, n);
    free(a); free(b);
    return !(r == 0);
}
