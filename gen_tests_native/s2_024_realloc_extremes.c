#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void) {
    char *p = (char *)malloc(65536);
    memset(p, 1, 65536);
    p = (char *)realloc(p, 1);
    p[0] = 5;
    p = (char *)realloc(p, 131072);
    memset(p + 1, 9, 131071);
    unsigned long chk = 0;
    for (size_t i = 0; i < 131072; i += 997) chk += (unsigned char)p[i];
    printf("chk=%lu\n", chk);
    free(p);
    return 0;
}
