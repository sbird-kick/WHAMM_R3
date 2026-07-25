#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    #define SN 64
    char *stack[SN];
    int top = 0;
    unsigned long chk = 0;
    for (int i = 0; i < 400; i++) {
        if (top < SN && (i % 3 != 0)) {
            size_t s = (size_t)(i % 200) + 16;
            char *p = (char *)malloc(s);
            memset(p, i & 0xFF, s);
            stack[top++] = p;
        } else if (top > 0) {
            top--;
            chk += (unsigned char)stack[top][0];
            free(stack[top]);
        }
    }
    while (top > 0) { top--; free(stack[top]); }
    printf("chk=%lu\n", chk);
    return 0;
}
