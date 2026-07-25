#include <stdio.h>

#include <stdlib.h>
#include <string.h>
int main() {
    printf("start %s %d\n", "s1_memset_memcpy_chain", 111);
    int n = 255;
    char stack1[256];
    memset(stack1, 111, n);
    char *heap = malloc(n);
    if (!heap) return 1;
    memcpy(heap, stack1, n);
    char stack2[256];
    memcpy(stack2, heap, n);
    int ok = 1;
    for (int i = 0; i < n; i++) if (stack2[i] != stack1[i]) ok = 0;
    free(heap);
    return !ok;
}
