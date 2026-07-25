#include <stdio.h>

#include <stdlib.h>
#include <string.h>
int main() {
    printf("start %s %d\n", "s1_multi_malloc_growth", 111);
    int total = 0;
    for (int i = 1; i <= 4; i++) {
        char *p = malloc(i * 4096);
        if (!p) return 1;
        memset(p, i, i * 4096);
        total += p[0];
    }
    return !(total > 0);
}
